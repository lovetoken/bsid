#' Convert oneframe picture about video data matrix (Only black and white)
#'
#' 영상정보 matrix 에 대하여 영상중 1프레임을 흑백사진으로 ploting 합니다.
#' @param x 영상정보 matrix 를 입력합니다.
#' @param picture 변환을 원하는 프레임을 입력합니다. 정수만 허락 합니다.
#' @param nc 영상 사진의 height 가 몇인지 입력합니다. 정수만 허락 합니다.
#' @export
#' @examples
#' ## not run
#' plot_vm(M, picture=1, nc=160)

plot_vm <- function(x, picture=1, width) {
  # pre
  stopifnot(require(pixmap))
  default <- par()$mar
  picture <- as.integer(picture)

  # function content
  par(mar=rep(0,4))
  adjust.x <- (x-min(x))/(max(x)-min(x))
  adjust.x[,picture] %>% as.vector %>% matrix(., ncol=width) %>% pixmapGrey %>% plot

  # round off
  par(mar=default)
}

#' Convert animation GIF picture about video data matrix
#'
#' 영상정보 matrix 를 animationGIF 파일로 변환시킵니다.
#' @param x 영상정보 matrix 를 입력합니다.
#' @param interval animation 의 interval 을 설정합니다. 기본값은 0.1초 입니다.
#' @param save.name 외부로 저장할 파일명을 문자열 형으로 설정합니다. 확장자는 \code{.gif} 로 이미 기 설정되어 있으므로 이를 고려하지 않습니다.
#' @param nc 영상 사진의 height 가 몇인지 입력합니다. 정수만 허락 합니다.
#' @return 워킹디렉토리에 "\{save.name\}.gif" 파일이 저장됩니다.
#' @details 본 함수는 \code{plot_vm()}, \code{animation::saveGIF()} 함수를 이용합니다.
#' 따라서 animation package 종속입니다.
#' @seealso \link{saveGIF}, \link{plot_vm}
#' @export
#' @examples
#' ## not run
#' save_anipic(M, nc=160)

save_anipic <- function(x, interval=0.1, save.name, ...){
  # pre
  stopifnot(require(animation))
  stopifnot(is.character(save.name))
  interal <- as.numeric(interval)

  # function content
  saveGIF(expr={
    for(i in seq(dim(x)[2])) plot_vm(x, picture=i, width=attributes(x)$width)
  }, interval=interval, movie.name=paste0(save.name, ".gif"), autobrowse = FALSE, ...)

  # round off
  ## message return
  message("successes convert GIF : ", getwd(), "/", save.name, ".gif")
}

