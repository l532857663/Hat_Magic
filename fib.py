#!/usr/bin/env python3
#-*- coding:utf-8 -*-

"""
斐波拉契数列
"""

import sys

def Fibonacci(theMax):
    """
    数列：1,1,2,3,5,8,13...
    """
    n, a, b = 0,0,1
    print(b)
    while n<theMax-1:
        a, b = b, b+a
        print(b)
        n += 1

if __name__ == "__main__":
    print("Start")
    count = int(sys.argv[1])
    Fibonacci(count)
    print("End")


