#!/usr/bin/env python3
#-*- coding:utf-8 -*-

"""
构画杨辉三角形
"""

import sys

def R1(a):
    b = [1]
    for x in range(1, len(a)):
        b.append(a[x]+a[x-1])
    b.append(1)
    return b

def EqTraingle(n):
    """
    画成直角三角形:
    function name: RightTraingle,
    param: n (输出三角形的层数)
    """
    print("{}层三角形".format(n))
    a = [1]
    for x in range(n):
        print(" "*(n-x-1),end="")
        for v in a:
            print(str(v)+" ",end="")
        a = R1(a)
        print()

if __name__ == "__main__":
    print("Start")
    count = int(sys.argv[1])
    EqTraingle(count)
    print("End")
