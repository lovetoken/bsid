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
#' WN_point(M, point.N.mean=100, point.N.sd=10, output.naming="Mstar")

WN_point <- function(x, point.N.mean=100, point.N.sd=10, save.env="bsid_env", output.naming=NULL){
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
