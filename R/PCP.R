#' PCP algorithm
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
#' PCP(M)
#' ls(bsid_env)
#'
#' # identify video of L, S
#' save_anipic(bsid_env$L, save.name="L")
#' save_anipic(bsid_env$S, save.name="S")

PCP <- function(x, iter.max=100, save.env="bsid_env", output.naming=NULL){
  # pre
  stopifnot(require(progress))
  iter.max <- as.integer(iter.max)
  stopifnot(is(output.naming, "character") | is.null(output.naming))
  if(!save.env %in% ls(globalenv())) assign(save.env, new.env(), envir=globalenv())
  n1 <- attributes(x)$n1
  n2 <- attributes(x)$n2

  # content
  S <- Y <- 0
  mu <- (n1*n2)/(4*sum(abs(x)))
  lamda <- sqrt(max(n1, n2))^(-1)
  delta <- 10^(-7)

  iter <- 1; pb <- progress_bar$new(total=iter.max)
  repeat{
    pb$tick()
    L <- Singular_value_thresholding_operator(mu^(-1), x-S+mu^(-1)*Y)
    S <- Shrinkage_operator(lamda*mu^(-1), x-L+mu^(-1)*Y)
    Y <- Y+mu*(x-L-S)

    # repeat break condition
    if (norm(x-L-S, "F") <= delta*norm(x, "F") | iter == iter.max){
      break
    }

    iter <- iter+1
  }

  # attributes of `L`, `S`
  attr(S, "width") <- attr(L, "width") <- attributes(x)$width
  attr(S, "height") <- attr(L, "height") <- attributes(x)$height
  attr(S, "n1") <- attr(L, "n1") <- attributes(x)$n1
  attr(S, "n2") <- attr(L, "n2") <- attributes(x)$n2

  # return
  assign("L", L, envir=get(save.env))
  assign("S", S, envir=get(save.env))
  if(is.character(output.naming)) save(L, S, file=paste0(output.naming, ".Rdata"))

  # round off
  message("L, S objects are saved (", save.env, "envir.)")
}
