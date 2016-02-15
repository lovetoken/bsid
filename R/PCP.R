#' PCP algorithm (미완성)
#'
#' PCP algorithm
#' @param x 영상정보 matrix 를 입력합니다.
#' @param n1
#' @param n2
#' @param iter.max
#' @param save.env 반환될 배경정보행렬 \code{L}, 전경정보행렬 \code{S} 객체의 환경을 지정합니다. 자세한 것은 value 장을 확인합니다.
#' @return \code{save.env} envirnoment 에 배경정보행렬 \code{L}, 전경정보행렬 \code{S} 객체가 반환됩니다. 전역환경이 아닌 임시환경에 저장되는 이유는 덮어쓰기를 방지하기 위함입니다.
#' @details 본 함수는 \code{Singular_value_thresholding_operator()}, \code{Shrinkage_operator()} 함수를 이용합니다.
#' @export
#' @examples

PCP <- function(x, n1, n2, iter.max=100, save.env="bsdi_env", output.naming=NULL){
  # pre
  stopifnot(is.integer(n1))
  stopifnot(is.integer(n2))
  stopifnot(is.integer(iter.max))
  stopifnot(is(output.naming, "character") | is.null(output.naming))
  if(!save.env %in% ls(globalenv())) assign(save.env, new.env(), envir=globalenv())

  # content
  S <- Y <- 0
  mu <- (n1*n2)/(4*sum(abs(M)))
  lamda <- sqrt(max(n1, n2))^(-1)
  delta <- 10^(-7)

  iter <- 1
  repeat{
    L <- Singular_value_thresholding_operator(mu^(-1), M-S+mu^(-1)*Y)
    S <- Shrinkage_operator(lamda*mu^(-1), M-L+mu^(-1)*Y)
    Y <- Y+mu*(M-L-S)

    # repeat break condition
    if (norm(M-L-S, "F") <= delta*norm(M, "F") | iter == iter.max){
      break
    }

    iter <- iter+1
  }

  # return
  assign("L", L, envir=get(save_env))
  assign("S", S, envir=get(save_env))
  if(is.character(output.naming)) save(L, S, file=paste0(output.naming, ".Rdata"))

  # round off
  message("L, S objects are saved (", save_env, "envir.)")
}
