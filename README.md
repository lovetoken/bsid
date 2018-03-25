creating M matrix
-----------------

M matrix 만들기 `creat_vm()`

    creat_vm(path="./example_data/airport_sub/")
    M <- bsid_env$M

*M* 확인하기 `save_anipic()`

    save_anipic(M, save.name="airport_sub_M")

![](airport_sub_M.gif)

PCP algorithm
-------------

Principal Component Pursuit algorithm 를 이용하여 L, S matrix 만들기
`PCP()`

    PCP(M)
    L <- bsid_env$L
    S <- bsid_env$S

*L*, *S* 확인하기

    save_anipic(L, save.name="airport_sub_L")
    save_anipic(S, save.name="airport_sub_S")

*L* matrix

![](airport_sub_L.gif)

*S* matrix

![](airport_sub_S.gif)

M matrix 에 PWN<sub>Point type White Noise</sub> 추가하기
---------------------------------------------------------

임의위치의 픽셀값을 1로 부여하여 잡음을 추가 `WN_point()`

    WN_point(M)
    Mstar <- bsid_env$Mstar

*M*<sup>⋆</sup> 확인하기

    save_anipic(Mstar, save.name="airport_sub_Mstar")

![](airport_sub_Mstar.gif)

Mstar PCP
---------

    PCP(Mstar)
    Lstar <- bsid_env$L
    Sstar <- bsid_env$S

    save_anipic(Lstar, save.name="airport_sub_Lstar")
    save_anipic(Sstar, save.name="airport_sub_Sstar")

*L*<sup>⋆</sup> 확인하기

![](airport_sub_Lstar.gif)

*S*<sup>⋆</sup> 확인하기

![](airport_sub_Sstar.gif)

Image Denoising
---------------

*M*<sup>′</sup> 만들기 (method="MDMR\_filter")

    denoising(Mstar, method="MDMR_filter", W0=1, lambda=0.1)
    Mprime <- bsid_env$prime

    save_anipic(Mprime, save.name="airport_sub_Mprime")

*M*<sup>′</sup> 확인하기

![](airport_sub_Mprime.gif)

*S*<sup>′</sup> 만들기 (method="median\_filter")

    denoising(Sstar, method="MDMR_filter", W0=1, lambda=0.1)
    Sprime <- bsid_env$prime

    save_anipic(Sprime, save.name="airport_sub_Sprime")

*S*<sup>′</sup> 확인하기

![](airport_sub_Sprime.gif)

*S*<sup>′</sup> + *L*<sup>⋆</sup> 확인하기

    Mpprime <- Sprime + Lstar

    save_anipic(Mpprime, save.name="airport_sub_Mpprime")

![](airport_sub_Mpprime.gif)

MSE compare
-----------

∣ ∣ *M* − *M*<sup>′</sup> ∣ ∣<sub>*F*</sub>

    norm(M-Mprime, type="F")

    ## [1] 83.78163

∣ ∣ *M* − (*S*<sup>′</sup> + *L*<sup>⋆</sup>) ∣ ∣<sub>*F*</sub>

    norm(M-Mpprime, type="F")

    ## [1] 43.66876

∣ ∣ *M* − *M*<sup>′</sup> ∣ ∣<sub>*F*</sub>  ≥   ∣ ∣*M* − (*S*<sup>′</sup> + *L*<sup>⋆</sup>) ∣ ∣<sub>*F*</sub>

-   email : <lt.lovetoken@gmail.com>
-   blog : <https://lovetoken.github.io/>
