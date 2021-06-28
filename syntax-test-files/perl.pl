#
# Minimal CONNECT proxy server for debugging
#
#   $ HTTPS_PROXY=http://127.0.0.1:3000 mojo get https://mojolicious.org
#
use Mojo::Base -strict, -signatures;
use Mojo::IOLoop;

my %buffer;
Mojo::IOLoop->server(
  {port => 3000} => sub ($loop, $stream, $id) {

    # Connection to client
    $stream->on(
      read => sub ($stream, $chunk) {

        # Write chunk from client to server
        my $server = $buffer{$id}{connection};
        return Mojo::IOLoop->stream($server)->write($chunk) if $server;

        # Read connect request from client
        my $buffer = $buffer{$id}{client} .= $chunk;
        if ($buffer =~ /\x0d?\x0a\x0d?\x0a$/) {
          $buffer{$id}{client} = '';
          if ($buffer =~ /CONNECT (\S+):(\d+)?/) {
            my ($address, $port) = ($1, $2 || 80);

            # Connection to server
            $buffer{$id}{connection} = Mojo::IOLoop->client(
              {address => $address, port => $port} => sub {
                my ($loop, $err, $stream) = @_;

                # Connection to server failed
                if ($err) {
                  say "Connection error for $address:$port: $err";
                  Mojo::IOLoop->remove($id);
                  return delete $buffer{$id};
                }

                # Start forwarding data in both directions
                say "Forwarding to $address:$port";
                Mojo::IOLoop->stream($id)->write("HTTP/1.1 200 OK\x0d\x0a" . "Connection: keep-alive\x0d\x0a\x0d\x0a");
                $stream->on(read => sub ($stream, $chunk) { Mojo::IOLoop->stream($id)->write($chunk) });

                # Server closed connection
                $stream->on(
                  close => sub {
                    Mojo::IOLoop->remove($id);
                    delete $buffer{$id};
                  }
                );
              }
            );
          }

          # Invalid request from client
          else { Mojo::IOLoop->remove($id) }
        }
      }
    );

    # Client closed connection
    $stream->on(
      close => sub {
        my $buffer = delete $buffer{$id};
        Mojo::IOLoop->remove($buffer->{connection}) if $buffer->{connection};
      }
    );
  }
);

print "Starting CONNECT proxy on port 3000.\n";
Mojo::IOLoop->start;

1;
