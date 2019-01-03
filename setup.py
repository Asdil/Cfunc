# -*- coding: utf-8 -*-
"""
-------------------------------------------------
   File Name：     setup
   Description :
   Author :        Asdil
   date：          2018/11/28
-------------------------------------------------
   Change Activity:
                   2018/11/28:
-------------------------------------------------
"""
__author__ = 'Asdil'
from distutils.core import setup
from Cython.Build import cythonize

setup(name='c_func',
      ext_modules=cythonize("c_func.pyx"))

# python setup.py build_ext --inplace