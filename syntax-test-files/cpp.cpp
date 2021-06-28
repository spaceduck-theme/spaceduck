//
//  ex13_17.cpp
//  Exercise 13.17
//
//  Created by pezy on 1/15/15.
//  Copyright (c) 2015 pezy. All rights reserved.
//
//  Write versions of numbered and f corresponding to the previous three
//  exercises
//  and check whether you correctly predicted the output.
//
//  For 13.16

#include <iostream>

class numbered {
public:
    numbered()
    {
        static int unique = 10;
        mysn = unique++;
    }

    numbered(const numbered& n) { mysn = n.mysn + 1; }

    int mysn;
};

void f(const numbered& s)
{
    std::cout << s.mysn << std::endl;
}

int main()
{
    numbered a, b = a, c = b;
    f(a);
    f(b);
    f(c);
}

// output
// 10
// 11
// 12

// Program 9.2a
// Floating-Point Inline Assembly - Clang/LLVM, GCC (32/64-bit)
// Copyright (c) 2017 Hall & Slonka

#include <iostream>
using namespace std;

int main(){

float var = 0;

// x87 floating-point example
   asm("finit \n\t"
       "fldpi \n\t"
       "fsqrt \n\t"
       "fstps %[var]"
       :[var] "=m" (var)
       :
       :
      );
   
   cout << var << endl;

// SSE scalar example
   var = 1.2;
   
   asm("movss %0, %%xmm0 \n\t"
       "addss %0, %%xmm0 \n\t"
       "movss %%xmm0, %0 \n\t"
       : "+x" (var)
       :
       : "%xmm0"
   );
   
   cout << var << endl;
   
   return 0;
}
