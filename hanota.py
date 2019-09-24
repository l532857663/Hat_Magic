#!/usr/bin/env python3
#-*- coding:utf-8 -*-

"""
汉诺塔移动方式，命令行取参数(几层汉诺塔)
"""

import sys

def hanoi(n,a,b,c):
    if (n == 1):
        print(a,"-->",c)
    else:
        hanoi(n-1,a,c,b)
        print(a,"-->",c)
        hanoi(n-1,b,a,c)

if __name__ == "__main__":
    count = int(sys.argv[1])
    hanoi(count, "A", "B", "C")
