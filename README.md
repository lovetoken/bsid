# Overview of bsid package
lovetoken  


```
##       open_packages before_version current_version
## 1         animation            2.4             2.4
## 2               bmp            0.2             0.2
## 3              bsid          0.113           0.113
## 4           corpcor          1.6.8           1.6.8
## 5             dplyr          0.4.3           0.4.3
## 6             knitr         1.12.3          1.12.3
## 7            pixmap         0.4-11          0.4-11
## 8          progress          1.0.2           1.0.2
## 9             servr          0.2.3           0.2.3
## 10 useful.lovetoken          0.124           0.124
```

*********************************************************************

# creating M matrix

Mmatrix 만들기


```r
creat_vm(path="./example_data/airport_sub/")
M <- bsid_env$M
```

M matrix 확인하기


```r
save_anipic(M, save.name="airport_sub_M")
```

```
## Executing: 
## 'convert' -loop 0 -delay 10 Rplot1.png Rplot2.png Rplot3.png
##     Rplot4.png Rplot5.png Rplot6.png Rplot7.png Rplot8.png
##     Rplot9.png Rplot10.png Rplot11.png Rplot12.png Rplot13.png
##     Rplot14.png Rplot15.png Rplot16.png Rplot17.png Rplot18.png
##     Rplot19.png Rplot20.png Rplot21.png Rplot22.png Rplot23.png
##     Rplot24.png Rplot25.png Rplot26.png Rplot27.png Rplot28.png
##     Rplot29.png Rplot30.png Rplot31.png Rplot32.png Rplot33.png
##     Rplot34.png Rplot35.png Rplot36.png Rplot37.png Rplot38.png
##     Rplot39.png Rplot40.png Rplot41.png Rplot42.png Rplot43.png
##     Rplot44.png Rplot45.png Rplot46.png Rplot47.png Rplot48.png
##     Rplot49.png Rplot50.png 'airport_sub_M.gif'
```

```
## Output at: airport_sub_M.gif
```

```
## successes convert GIF : /Users/lovetoken/Desktop/OneDrive/02_Study/01_Statistic/31_R/02_MyPackage/bsid/airport_sub_M.gif
```

![](airport_sub_M.gif)

# PCP


```r
PCP(M)
```

```
## L, S objects are saved (bsid_envenvir.)
```

```r
L <- bsid_env$L
S <- bsid_env$S
```

L, S matrix 확인하기


```r
save_anipic(L, save.name="airport_sub_L")
```

```
## Executing: 
## 'convert' -loop 0 -delay 10 Rplot1.png Rplot2.png Rplot3.png
##     Rplot4.png Rplot5.png Rplot6.png Rplot7.png Rplot8.png
##     Rplot9.png Rplot10.png Rplot11.png Rplot12.png Rplot13.png
##     Rplot14.png Rplot15.png Rplot16.png Rplot17.png Rplot18.png
##     Rplot19.png Rplot20.png Rplot21.png Rplot22.png Rplot23.png
##     Rplot24.png Rplot25.png Rplot26.png Rplot27.png Rplot28.png
##     Rplot29.png Rplot30.png Rplot31.png Rplot32.png Rplot33.png
##     Rplot34.png Rplot35.png Rplot36.png Rplot37.png Rplot38.png
##     Rplot39.png Rplot40.png Rplot41.png Rplot42.png Rplot43.png
##     Rplot44.png Rplot45.png Rplot46.png Rplot47.png Rplot48.png
##     Rplot49.png Rplot50.png 'airport_sub_L.gif'
```

```
## Output at: airport_sub_L.gif
```

```
## successes convert GIF : /Users/lovetoken/Desktop/OneDrive/02_Study/01_Statistic/31_R/02_MyPackage/bsid/airport_sub_L.gif
```

```r
save_anipic(S, save.name="airport_sub_S")
```

```
## Executing: 
## 'convert' -loop 0 -delay 10 Rplot1.png Rplot2.png Rplot3.png
##     Rplot4.png Rplot5.png Rplot6.png Rplot7.png Rplot8.png
##     Rplot9.png Rplot10.png Rplot11.png Rplot12.png Rplot13.png
##     Rplot14.png Rplot15.png Rplot16.png Rplot17.png Rplot18.png
##     Rplot19.png Rplot20.png Rplot21.png Rplot22.png Rplot23.png
##     Rplot24.png Rplot25.png Rplot26.png Rplot27.png Rplot28.png
##     Rplot29.png Rplot30.png Rplot31.png Rplot32.png Rplot33.png
##     Rplot34.png Rplot35.png Rplot36.png Rplot37.png Rplot38.png
##     Rplot39.png Rplot40.png Rplot41.png Rplot42.png Rplot43.png
##     Rplot44.png Rplot45.png Rplot46.png Rplot47.png Rplot48.png
##     Rplot49.png Rplot50.png 'airport_sub_S.gif'
```

```
## Output at: airport_sub_S.gif
```

```
## successes convert GIF : /Users/lovetoken/Desktop/OneDrive/02_Study/01_Statistic/31_R/02_MyPackage/bsid/airport_sub_S.gif
```

![](airport_sub_L.gif)
![](airport_sub_S.gif)

# Mmatrix 에 point type WN 추가하기


```r
WN_point(M)
```

```
## Complete Point Type(PWN=100, sd=10) Noise Addition
```

```r
Mstar <- bsid_env$Mstar
```

확인하기


```r
save_anipic(Mstar, save.name="airport_sub_Mstar")
```

```
## Executing: 
## 'convert' -loop 0 -delay 10 Rplot1.png Rplot2.png Rplot3.png
##     Rplot4.png Rplot5.png Rplot6.png Rplot7.png Rplot8.png
##     Rplot9.png Rplot10.png Rplot11.png Rplot12.png Rplot13.png
##     Rplot14.png Rplot15.png Rplot16.png Rplot17.png Rplot18.png
##     Rplot19.png Rplot20.png Rplot21.png Rplot22.png Rplot23.png
##     Rplot24.png Rplot25.png Rplot26.png Rplot27.png Rplot28.png
##     Rplot29.png Rplot30.png Rplot31.png Rplot32.png Rplot33.png
##     Rplot34.png Rplot35.png Rplot36.png Rplot37.png Rplot38.png
##     Rplot39.png Rplot40.png Rplot41.png Rplot42.png Rplot43.png
##     Rplot44.png Rplot45.png Rplot46.png Rplot47.png Rplot48.png
##     Rplot49.png Rplot50.png 'airport_sub_Mstar.gif'
```

```
## Output at: airport_sub_Mstar.gif
```

```
## successes convert GIF : /Users/lovetoken/Desktop/OneDrive/02_Study/01_Statistic/31_R/02_MyPackage/bsid/airport_sub_Mstar.gif
```

![](airport_sub_Mstar.gif)

# Mstar PCP


```r
PCP(Mstar)
```

```
## L, S objects are saved (bsid_envenvir.)
```

```r
Lstar <- bsid_env$L
Sstar <- bsid_env$S
```

확인하기


```r
save_anipic(Lstar, save.name="airport_sub_Lstar")
```

```
## Executing: 
## 'convert' -loop 0 -delay 10 Rplot1.png Rplot2.png Rplot3.png
##     Rplot4.png Rplot5.png Rplot6.png Rplot7.png Rplot8.png
##     Rplot9.png Rplot10.png Rplot11.png Rplot12.png Rplot13.png
##     Rplot14.png Rplot15.png Rplot16.png Rplot17.png Rplot18.png
##     Rplot19.png Rplot20.png Rplot21.png Rplot22.png Rplot23.png
##     Rplot24.png Rplot25.png Rplot26.png Rplot27.png Rplot28.png
##     Rplot29.png Rplot30.png Rplot31.png Rplot32.png Rplot33.png
##     Rplot34.png Rplot35.png Rplot36.png Rplot37.png Rplot38.png
##     Rplot39.png Rplot40.png Rplot41.png Rplot42.png Rplot43.png
##     Rplot44.png Rplot45.png Rplot46.png Rplot47.png Rplot48.png
##     Rplot49.png Rplot50.png 'airport_sub_Lstar.gif'
```

```
## Output at: airport_sub_Lstar.gif
```

```
## successes convert GIF : /Users/lovetoken/Desktop/OneDrive/02_Study/01_Statistic/31_R/02_MyPackage/bsid/airport_sub_Lstar.gif
```

```r
save_anipic(Sstar, save.name="airport_sub_Sstar")
```

```
## Executing: 
## 'convert' -loop 0 -delay 10 Rplot1.png Rplot2.png Rplot3.png
##     Rplot4.png Rplot5.png Rplot6.png Rplot7.png Rplot8.png
##     Rplot9.png Rplot10.png Rplot11.png Rplot12.png Rplot13.png
##     Rplot14.png Rplot15.png Rplot16.png Rplot17.png Rplot18.png
##     Rplot19.png Rplot20.png Rplot21.png Rplot22.png Rplot23.png
##     Rplot24.png Rplot25.png Rplot26.png Rplot27.png Rplot28.png
##     Rplot29.png Rplot30.png Rplot31.png Rplot32.png Rplot33.png
##     Rplot34.png Rplot35.png Rplot36.png Rplot37.png Rplot38.png
##     Rplot39.png Rplot40.png Rplot41.png Rplot42.png Rplot43.png
##     Rplot44.png Rplot45.png Rplot46.png Rplot47.png Rplot48.png
##     Rplot49.png Rplot50.png 'airport_sub_Sstar.gif'
```

```
## Output at: airport_sub_Sstar.gif
```

```
## successes convert GIF : /Users/lovetoken/Desktop/OneDrive/02_Study/01_Statistic/31_R/02_MyPackage/bsid/airport_sub_Sstar.gif
```

![](airport_sub_Lstar.gif)
![](airport_sub_Sstar.gif)

# Image Denoising

구현중입니다.

**********************************************************************


