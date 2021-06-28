#Juggling Algorithm for array rotation!
#Time complexity: O(n) , Auxiliary-Space: O(1)


def left_rotate_array(a, d) #Input array "a" and rotation by "d" elemets
    n=a.length
    if n>0 
        if d>n              # if d>n ,we take modulo n 
            d%=n
        end
        
        for i in 0...gcd(d,n)
            temp=a[i]
            j=i
            while(true)
             k=j+d
             if k>=n
                 k=k-n
             end
             if k==i
                 break
             end
             a[j]=a[k]
             j=k
            end
            a[j]=temp
        end
            
    end
  return a
end


def gcd(x,y)
    if y==0
        return x
    else
      return gcd(y,x%y)
    end
end
