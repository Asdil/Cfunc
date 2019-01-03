# -*- coding: utf-8 -*-
"""
-------------------------------------------------
   File Name：     c_func.pyx
   Description :
   Author :        Asdil
   date：          2018/9/3
-------------------------------------------------
   Change Activity:
                   2018/9/3:
-------------------------------------------------
"""
__author__ = 'Asdil'
# 将str链转化为int链
cpdef list c_chan2int(list chan, list ref):
    assert len(chan) == len(ref)
    cdef int i
    cdef list ret = []
    for i in range(len(chan)):
        if chan[i] == ref[i]:
            ret.append(0)
        else:
            ret.append(1)
    return ret
# 拆分sfs链，成两条链
cpdef list c_splitChans(list chans, str sep):
    cdef int i
    cdef list chanA = []
    cdef list chanB = []
    cdef str A
    cdef str B
    if not sep:
        for i in range(len(chans)):
            A, B = chans[i][0], chans[i][1]
            chanA.append(A)
            chanB.append(B)
    else:
        for i in range(len(chans)):
            A, B = chans[i].split(sep)
            chanA.append(A)
            chanB.append(B)
    return [chanA, chanB]
# 创造sps文件
cpdef str c_createSps(list ref, list alt, list chanA, list chanB):
    assert len(chanA) == len(chanB)
    cdef list ret = []
    for i in range(len(chanA)):
        if ref[i] == '-' and alt[i] == '-':
            ret.append('.')
        elif chanA[i] == '-' or chanB == '-':
            ret.append('.')
        elif chanA[i] != chanB[i]:
            if chanA[i] not in [ref[i], alt[i]] or chanB[i] not in [ref[i], alt[i]]:
                ret.append('.')
            else:
                ret.append('1')
        elif chanA[i] == ref[i]:
            ret.append('0')
        elif chanA[i] == alt[i]:
            ret.append('2')
        else:
            ret.append('.')
    return ''.join(ret)

# 将多样本的predict int转列表化为ref和alt
cpdef list int2snpsfs(list predicts, str ref, str alt, str sep):
    cdef list ret = []
    cdef list sfs = []
    cdef list snp = []
    cdef int predict
    cdef list _list
    # 开始处理sfs
    for predict in predicts:
        if predict == 0:
            ret.append(ref)
        else:
            ret.append(alt)
    ret = [ret[i:i + 2] for i in range(0, len(ret), 2)]
    
    for _list in ret:
        sfs.append(sep.join(_list))
    
    # 开始处理snp
    if (len(ref) > 1 and len(alt)==1) or (len(ref) == 1 and len(alt) > 1):
        ret = []
        if len(ref) > 1:
            ref = 'I'
            alt = 'D'
        else:
            ref = 'D'
            alt = 'I'
        for predict in predicts:
            if predict == 0:
                ret.append(ref)
            else:
                ret.append(alt)
        ret = [ret[i:i+2] for i in range(0, len(ret), 2)]
        for _list in ret:
            snp.append(''.join(sorted(_list)))
    elif len(ref) > 1 and len(alt) > 1:
        snp = ['--'] * len(ret)
    else:
        for _list in ret:
            snp.append(''.join(sorted(_list)))
    assert len(sfs) == len(snp)
    return [sfs, snp]


cpdef hp():
    print('将str链转化为int链 c_chan2int(list chan, list ref)')
    print('拆分sfs链，成两条链 c_splitChans(list chans, str sep)')
    print('创造sps文件 c_createSps(list ref, list alt, list chanA, list chanB)')
    print('还原预测文件 int2snpsfs(predicts, ref, alt, sep) sep为sfs分隔符')