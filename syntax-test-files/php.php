<?php

namespace App;
namespace WEBIZ\LaravelFakturoid;

use Illuminate\Contracts\Auth\MustVerifyEmail as ContractMustVerifyEmail;
use Litepie\User\Models\Client as BaseClient;
use Litepie\User\Traits\Auth\MustVerifyEmail;

class Client extends BaseClient implements ContractMustVerifyEmail
{
    use MustVerifyEmail;
    /**
     * Configuartion for the model.
     *
     * @var array
     */
    protected $config = 'users.client.model';

    /**
     * Roles for the user type.
     *
     * @var array
     */
    protected $role = 'client';
}

use Illuminate\Support\ServiceProvider;
use WEBIZ\LaravelFakturoid\LaravelFakturoid;


class FakturoidServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap the application services.
     */
    public function boot()
    {
        if ($this->app->runningInConsole()) {
            $this->publishes([
                __DIR__ . '/../config/fakturoid.php' => config_path('fakturoid.php'),
            ], 'config');
        }
    }

    /**
     * Register services.
     *
     * @return void
     */
    public function register()
    {
        // Automatically apply the package configuration
        $this->mergeConfigFrom(__DIR__ . '/../config/fakturoid.php', 'fakturoid');

        // Register the main class to use with the facade
        $this->app->singleton('laravel-fakturoid', function () {
            return new LaravelFakturoid;
        });
    }
}
