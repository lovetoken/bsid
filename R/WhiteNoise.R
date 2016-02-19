#' Point type white noise addition of vedio matrix
#'
#' Point type white noise addition of vedio matrix.
#' $M$ matrix 에 white noise 를 부여하여 $M^\star$ 를 만들며, 잡음타입은 랜덤하게 부여된 point type white noise 입니다.
#' @param x 영상정보 matrix 를 입력합니다.
#' @param point.N.mean 부여하고싶은 point white noise 개수의 평균을 입력합니다.
#' @param point.N.sd 부여하고싶은 point white noise 개수의 표준편차를 입력합니다.
#' @param save.env 반환될 잡음추가 영상행렬 \code{Mstar} 객체의 환경을 지정합니다. 자세한 것은 value 장을 확인합니다.
#' @return \code{save.env} envirnoment 에 잡음추가 영상행렬 \code{Mstar} 객체가 반환됩니다. 전역환경이 아닌 임시환경에 저장되는 이유는 덮어쓰기를 방지하기 위함입니다.
#' @export
#' @examples
#' WN_point(M, output.naming="Mstar")

WN_point <- function(x, point.N.mean=attributes(x)$n1*.01, point.N.sd=10, save.env="bsid_env", output.naming=NULL){
  # pre
  stopifnot(require(dplyr))
  stopifnot(is.numeric(point.N.mean))
  stopifnot(is.numeric(point.N.sd))
  stopifnot(is(output.naming, "character") | is.null(output.naming))
  if(!save.env %in% ls(globalenv())) assign(save.env, new.env(), envir=globalenv())
  n1 <- attributes(x)$n1
  n2 <- attributes(x)$n2

  # content
  for(j in seq(n2)){
    PWN.N <- round(rnorm(1, point.N.mean, point.N.sd)) %>% abs
    PWN.index <- sample(seq(n1), PWN.N)
    x[PWN.index, j] <- 1 # White Noise addition
  }

  Mstar <- x; rm(x)
  message("Complete Point Type(PWN=", point.N.mean, ", sd=", point.N.sd, ") Noise Addition\n", sep="")

  # return
  assign("Mstar", Mstar, envir=get(save.env))
  if(is.character(output.naming)) save(Mstar, file=paste0(output.naming, ".Rdata"))

}

#' Line type white noise addition of vedio matrix
#'
#' Line type white noise addition of vedio matrix.
#' $M$ matrix 에 white noise 를 부여하여 $M^\star$ 를 만들며, 잡음타입은 랜덤하게 부여된 line type white noise 입니다.
#' @param x 영상정보 matrix 를 입력합니다.
#' @param save.env 반환될 잡음추가 영상행렬 \code{Mstar} 객체의 환경을 지정합니다. 자세한 것은 value 장을 확인합니다.
#' @return \code{save.env} envirnoment 에 잡음추가 영상행렬 \code{Mstar} 객체가 반환됩니다. 전역환경이 아닌 임시환경에 저장되는 이유는 덮어쓰기를 방지하기 위함입니다.
#' @export
#' @examples
#' WN_line(M, output.naming="Mstar")

WN_line <- function(x, line.N.weight=0.1, line.sd=10, line.length.weight=0.3,
                    save.env="bsid_env", output.naming=NULL, direction=c("width", "height")){
  # pre
  stopifnot(require(dplyr))
  stopifnot(is.numeric(line.N.weight))
  stopifnot(is.numeric(line.sd))
  stopifnot(is.numeric(line.length.weight))
  stopifnot(is(output.naming, "character") | is.null(output.naming))
  if(!save.env %in% ls(globalenv())) assign(save.env, new.env(), envir=globalenv())
  n1 <- attributes(x)$n1
  n2 <- attributes(x)$n2

  # content
  if(direction=="width"){

    for(j in seq(n2)){

      LWN.N <- rnorm(1, line.N.weight*attributes(x)$height, line.sd) %>% round %>% abs
      line.length <- line.length.weight*attributes(x)$width %>% round
      total.info <- cbind(h=attributes(x)$height %>% seq %>% sample(size=LWN.N),
                          w=attributes(x)$width %>% seq %>% sample(size=LWN.N),
                          W0=(rnorm(LWN.N, line.length, line.sd)/2) %>% round %>% abs) %>% as.data.frame

      iter <- matrix(NA, 1, 2)
      for(a in total.info %>% nrow %>% seq){

        melted <- cbind(h=total.info[a,1], w=window(total.info[a,3], total.info[a,2], 1, attributes(x)$width))
        iter <- rbind(iter, melted)

      }

      res <- iter[-1, ]
      LWN.index <- res[,1]+attributes(x)$height*(res[,2]-1)
      x[LWN.index, j] <- 1 # White Noise addition

    }

  } else if(direction=="height"){

    for(j in seq(n2)){

      LWN.N <- rnorm(1, line.N.weight*attributes(x)$width, line.sd) %>% round %>% abs
      line.length <- line.length.weight*attributes(x)$width %>% round
      total.info <- cbind(h=attributes(x)$height %>% seq %>% sample(size=LWN.N),
                          w=attributes(x)$width %>% seq %>% sample(size=LWN.N),
                          W0=(rnorm(LWN.N, line.length, line.sd)/2) %>% round %>% abs) %>% as.data.frame

      iter <- matrix(NA, 1, 2)
      for(a in total.info %>% nrow %>% seq){

        melted <- cbind(w=total.info[a,2], h=window(total.info[a,3], total.info[a,1], 1, attributes(x)$height))
        iter <- rbind(iter, melted)

      }

      res <- iter[-1, c(2,1)]
      LWN.index <- res[,1]+attributes(x)$height*(res[,2]-1)
      x[LWN.index, j] <- 1 # White Noise addition

    }

  }

  Mstar <- x; rm(x)
  message("Complete Point Type(LWN=", line.N.weight*100, ", sd=", line.sd, ") Noise Addition\n", sep="")

  # return
  assign("Mstar", Mstar, envir=get(save.env))
  if(is.character(output.naming)) save(Mstar, file=paste0(output.naming, ".Rdata"))

}
