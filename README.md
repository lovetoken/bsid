# Overview of bsid package



Background Subtraction and Image Denoising (BSID) R package

*********************************************************************

# Example bsid package in R

## creating M matrix

M matrix 만들기 `creat_vm()`


```r
creat_vm(path="./example_data/airport_sub/")
M <- bsid_env$M
```

$M$ 확인하기 `save_anipic()`


```r
save_anipic(M, save.name="airport_sub_M")
```

![](airport_sub_M.gif)

## PCP algorithm

Principal Component Pursuit algorithm 를 이용하여 L, S matrix 만들기 `PCP()`


```r
PCP(M)
L <- bsid_env$L
S <- bsid_env$S
```

$L, S$ 확인하기


```r
save_anipic(L, save.name="airport_sub_L")
save_anipic(S, save.name="airport_sub_S")
```

$L$ matrix

![](airport_sub_L.gif)

$S$ matrix

![](airport_sub_S.gif)

## M matrix 에 PWN<sub>Point type White Noise</sub> 추가하기

임의위치의 픽셀값을 1로 부여하여 잡음을 추가 `WN_point()`


```r
WN_point(M)
Mstar <- bsid_env$Mstar
```

$M^\star$ 확인하기


```r
save_anipic(Mstar, save.name="airport_sub_Mstar")
```

![](airport_sub_Mstar.gif)

## Mstar PCP


```r
PCP(Mstar)
Lstar <- bsid_env$L
Sstar <- bsid_env$S
```


```r
save_anipic(Lstar, save.name="airport_sub_Lstar")
save_anipic(Sstar, save.name="airport_sub_Sstar")
```

$L^\star$ 확인하기

![](airport_sub_Lstar.gif)

$S^\star$ 확인하기

![](airport_sub_Sstar.gif)

## Image Denoising

coming soon.

## MSE compare

coming soon.

# **bsid** package (in R) Maintainer

Song HyoJin 

- Korean R user
- [HUFS](http://www.hufs.ac.kr/user/hufsenglish/) student 
- email : <lt.lovetoken@gmail.com>
- blog : <http://lovetoken.dothome.co.kr/>

**********************************************************************


