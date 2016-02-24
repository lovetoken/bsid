#' Denoising function
#'
#' Denoising function
#'
#' @param x 영상정보 matrix 를 입력합니다.
#' @return
#' @export
#' @examples
#'
denoising <- function(x, method=c("mean", "median", "MDMR", "cross_shape_mean", "cross_shape_median", "cross_shape_MDMR", "mean_oneframe", "median_oneframe", "auto_outlier_filter", "median_filter"),
                      W0, lambda, save.env="bsid_env", output.naming=NULL, ...){
  # pre
  stopifnot(require(dplyr)); stopifnot(require(progress))
  stopifnot(method %in% c("mean", "median", "MDMR", "cross_shape_mean", "cross_shape_median", "cross_shape_MDMR", "mean_oneframe", "median_oneframe", "auto_outlier_filter", "median_filter"))
  stopifnot(is(output.naming, "character") | is.null(output.naming))
  if(!save.env %in% ls(globalenv())) assign(save.env, new.env(), envir=globalenv())
  n1 <- attributes(x)$n1
  n2 <- attributes(x)$n2

  # Denoising copy objects
  star <- x
  prime <- star

  # Method choice
  if(method=="mean_oneframe"){

    # Mean method(Only oneframe) denoising algorithm
    for(n in seq(n2)){
      Frame.picture <- matrix(star[,n], ncol=attributes(x)$width)
      trans.Frame.picture <- Frame.picture

      for(i in seq(attributes(x)$height)){
        for(j in seq(attributes(x)$width)){
          if(abs(mean(Frame.picture[window(W0, i, 1, attributes(x)$height), window(W0, j, 1, attributes(x)$width)])-Frame.picture[i,j])>=lambda){

            trans.Frame.picture[i,j] <- mean(Frame.picture[window(W0, i, 1, attributes(x)$height), window(W0, j, 1, attributes(x)$width)])

          } else {
            next
          }
        }
      }

      prime[,n] <- c(trans.Frame.picture)

    }

  } else if(method=="median_oneframe"){

    # Median method(Only oneframe) denoising algorithm
    for(n in seq(n2)){
      Frame.picture <- matrix(star[,n], ncol=attributes(x)$width)
      trans.Frame.picture <- Frame.picture

      for(i in seq(attributes(x)$height)){
        for(j in seq(attributes(x)$width)){
          if(abs(median(Frame.picture[window(W0, i, 1, attributes(x)$height), window(W0, j, 1, attributes(x)$width)])-Frame.picture[i,j])>=lambda){

            trans.Frame.picture[i,j] <- median(Frame.picture[window(W0, i, 1, attributes(x)$height), window(W0, j, 1, attributes(x)$width)])

          } else {
            next
          }
        }
      }

      prime[,n] <- c(trans.Frame.picture)

    }

  } else if(method=="mean"){

    # Mean method denoising algorithm
    for(i in seq(n1)){

      # ith row Mmatrix scale >> real picture scale
      h <- i%%attributes(x)$height
      w <- (i%/%attributes(x)$height)+1

      # real picture center scale >> return to detect spatial range >> Mmatix scaling
      frame.scale <- expand.grid(h.detect=window(W0, h, 1, attributes(x)$height), w.detect=window(W0, w, 1, attributes(x)$width))
      matrix.scale <- frame.scale$h.detect+attributes(x)$height*(frame.scale$w.detect-1)

      for(j in seq(n2)){
        if(abs(mean(star[matrix.scale, window(W0, j, 1, n2)])-star[i,j])>=lambda){

          prime[i,j] <- mean(star[matrix.scale, window(W0, j, 1, n2)])

        } else {
          next
        }

      }

    }

  } else if(method=="median"){

    # Median method denoising algorithm
    for(i in seq(n1)){

      # ith row Mmatrix scale >> real picture scale
      h <- i%%attributes(x)$height
      w <- (i%/%attributes(x)$height)+1

      # real picture center scale >> return to detect spatial range >> Mmatix scaling
      frame.scale <- expand.grid(h.detect=window(W0, h, 1, attributes(x)$height), w.detect=window(W0, w, 1, attributes(x)$width))
      matrix.scale <- frame.scale$h.detect+attributes(x)$height*(frame.scale$w.detect-1)

      for(j in seq(n2)){
        if(abs(median(star[matrix.scale, window(W0, j, 1, n2)])-star[i,j])>=lambda){

          prime[i,j] <- median(star[matrix.scale, window(W0, j, 1, n2)])

        } else {
          next
        }

      }

    }

  } else if(method=="MDMR"){

    # Median detect after mean value replace method(MDMR) denoising algorithm
    for(i in seq(n1)){

      # ith row Mmatrix scale >> real picture scale
      h <- i%%attributes(x)$height
      w <- (i%/%attributes(x)$height)+1

      # real picture center scale >> return to detect spatial range >> Mmatix scaling
      frame.scale <- expand.grid(h.detect=window(W0, h, 1, attributes(x)$height), w.detect=window(W0, w, 1, attributes(x)$width))
      matrix.scale <- frame.scale$h.detect+attributes(x)$height*(frame.scale$w.detect-1)

      for(j in seq(n2)){
        if(abs(median(star[matrix.scale, window(W0, j, 1, n2)])-star[i,j])>=lambda){

          prime[i,j] <- mean(star[matrix.scale, window(W0, j, 1, n2)])

        } else {
          next
        }

      }

    }

  } else if(method=="cross_shape_mean"){

    # Cross shape mean detect denoising algorithm
    for(i in seq(n1)){

      # ith row Mmatrix scale >> real picture scale
      h <- i%%attributes(x)$height
      w <- (i%/%attributes(x)$height)+1

      # real picture center scale >> return to detect spatial range >> Mmatix scaling
      frame.scale <- expand.grid(h.detect=window(W0, h, 1, attributes(x)$height), w.detect=window(W0, w, 1, attributes(x)$width))
      matrix.scale <- frame.scale$h.detect+attributes(x)$height*(frame.scale$w.detect-1)

      for(j in seq(n2)){
        if(abs(mean(c(star[matrix.scale, j], star[n1, window(W0, j, 1, n2)]))-star[i,j])>=lambda){

          prime[i,j] <- mean(c(star[matrix.scale, j], star[n1, window(W0, j, 1, n2)]))

        } else {
          next
        }

      }

    }

  } else if(method=="cross_shape_median"){

    # Cross shape median detect denoising algorithm
    for(i in seq(n1)){

      # ith row Mmatrix scale >> real picture scale
      h <- i%%attributes(x)$height
      w <- (i%/%attributes(x)$height)+1

      # real picture center scale >> return to detect spatial range >> Mmatix scaling
      frame.scale <- expand.grid(h.detect=window(W0, h, 1, attributes(x)$height), w.detect=window(W0, w, 1, attributes(x)$width))
      matrix.scale <- frame.scale$h.detect+attributes(x)$height*(frame.scale$w.detect-1)

      for(j in seq(n2)){
        if(abs(median(c(star[matrix.scale, j], star[n1, window(W0, j, 1, n2)]))-star[i,j])>=lambda){

          prime[i,j] <- median(c(star[matrix.scale, j], star[n1, window(W0, j, 1, n2)]))

        } else {
          next
        }

      }

    }

  } else if(method=="cross_shape_MDMR"){

    # Cross shape MDMR denoising algorithm
    for(i in seq(n1)){

      # ith row Mmatrix scale >> real picture scale
      h <- i%%attributes(x)$height
      w <- (i%/%attributes(x)$height)+1

      # real picture center scale >> return to detect spatial range >> Mmatix scaling
      frame.scale <- expand.grid(h.detect=window(W0, h, 1, attributes(x)$height), w.detect=window(W0, w, 1, attributes(x)$width))
      matrix.scale <- frame.scale$h.detect+attributes(x)$height*(frame.scale$w.detect-1)

      for(j in seq(n2)){
        if(abs(median(c(star[matrix.scale, j], star[n1, window(W0, j, 1, n2)]))-star[i,j])>=lambda){

          prime[i,j] <- mean(c(star[matrix.scale, j], star[n1, window(W0, j, 1, n2)]))

        } else {
          next
        }

      }

    }

  } else if(method=="auto_outlier_filter"){

    # Auto_outlier_filter method denoising algorithm : lambda 인자가 필요 없으나 인자를 빼면 안됨
    Mdf_for_prime <- prime_for_prime <- matrix(NA, n1, n2)
    for(i in seq(n1)){

      # ith row Mmatrix scale >> real picture scale
      h <- i%%attributes(x)$height
      w <- (i%/%attributes(x)$height)+1

      # real picture center scale >> return to detect spatial range >> Mmatix scaling
      frame.scale <- expand.grid(h.detect=window(W0, h, 1, attributes(x)$height), w.detect=window(W0, w, 1, attributes(x)$width))
      matrix.scale <- frame.scale$h.detect+attributes(x)$height*(frame.scale$w.detect-1)

      for(j in seq(n2)){

        prime_for_prime[i, j] <- median(star[matrix.scale, window(W0, j, 1, n2)])
        Mdf_for_prime[i, j] <- abs(mean(star[matrix.scale, window(W0, j, 1, n2)])-star[i,j])

      }

    }

    Mnoise_detect <- apply(Mdf_for_prime, 2, function(x) outlier_detect(x)) # within "Sub_Function.R" script

    for(i in seq(n1)){
      for(j in seq(n2)){
        if(Mnoise_detect[i,j]==TRUE){
          prime[i,j] <- prime_for_prime[i, j]
        } else {
          next
        }
      }

    }

  } else if(method=="median_filter"){

    # Median_filter method denoising algorithm
    Mdf_for_prime <- prime_for_prime <- matrix(NA, n1, n2)
    pb <- progress_bar$new(total=n1)
    for(i in seq(n1)){

      pb$tick()
      # ith row Mmatrix scale >> real picture scale
      h <- i%%attributes(x)$height
      w <- (i%/%attributes(x)$height)+1

      # real picture center scale >> return to detect spatial range >> Mmatix scaling
      frame.scale <- expand.grid(h.detect=window(W0, h, 1, attributes(x)$height), w.detect=window(W0, w, 1, attributes(x)$width))
      matrix.scale <- frame.scale$h.detect+attributes(x)$height*(frame.scale$w.detect-1)

      for(j in seq(n2)){

        prime_for_prime[i, j] <- median(star[matrix.scale, window(W0, j, 1, n2)])
        Mdf_for_prime[i, j] <- abs(median(star[matrix.scale, window(W0, j, 1, n2)])-star[i,j])

      }

    }

    Mnoise_detect <- apply(Mdf_for_prime, 2, function(x) x>=quantile(x, probs=1-lambda))

    for(i in seq(n1)){
      for(j in seq(n2)){
        if(Mnoise_detect[i,j]==TRUE){
          prime[i,j] <- prime_for_prime[i, j]
        } else {
          next
        }
      }

    }

  } # method choice exit

  # return
  assign("prime", prime, envir=get(save.env))
  if(is.character(output.naming)) save(M, file=paste0(output.naming, ".Rdata"))

}
