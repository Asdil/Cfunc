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

# 如果cimport numpy as np
# cimport numpy 在pyx不能注释
# from distutils.core import setup
# from Cython.Build import cythonize
# import numpy as np
# import os
# os.environ["C_INCLUDE_PATH"] = np.get_include()
# setup(name='c_func',
#       ext_modules=cythonize("c_func.pyx"))
