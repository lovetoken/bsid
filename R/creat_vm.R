#' Create vedio matrix
#'
#' 순차적으로 저장되어있는 영상 프레임 (bmp, jpg, jpeg format 만 현재 지원) 워킹디렉토리를 지정시 vedio matrix 를 만들어 반환합니다.
#' 반환되는 객체는 vm class로 본 내용물은 행렬이며, 원본 프레임의 메타정보 들은(e.g n1, n2) 속성값으로 저장됩니다.
#' @param wd 영상프레임 집합의 path 를 vector 형식으로 입력합니다.
#' @param output.naming 이 인자에 값을 부여하면 반환되는 vedio matrix 를 .Rdata 형식파일을 외부로 저장시킵니다.
#' @param ... \code{wd} 인자값을 \code{dir(...)} 로 지정합니다. 이에 대한 상속인자를 조정할 수 있습니다.
#' @return
#' @details
#' @export

creat_vm <- function(wd = dir(full.names = T, ...), save.env = "bsid_env", output.naming = NULL, format = "bmp", ...){

  stopifnot(require(bmp), require(pixmap), require(progress), require(jpeg))
  stopifnot(is(output.naming, "character") | is.null(output.naming))
  stopifnot(is(format, "character"))
  stopifnot(is(wd, "vector"))

  wd <- sort(wd)
  if(!save.env %in% ls(globalenv())) assign(save.env, new.env(), envir=globalenv())

  # content

  # if(rgb==TRUE){ # rgb 구현중
    # filename <- filename.fun(dir, main.name, seq.start, seq.end)
    #
    # # width & height value setting
    # read <- read.bmp(filename[1])
    #
    # width <- attributes(read)$header$width
    # height <- attributes(read)$header$height
    #
    # # M matrix space
    # MR <- matrix(NA, nrow=width*height, ncol=length(filename))
    # MG <- matrix(NA, nrow=width*height, ncol=length(filename))
    # MB <- matrix(NA, nrow=width*height, ncol=length(filename))
    #
    # # M matrix space <- grey scale pixel value
    #
    # for(i in seq(length(filename))){
    #   readbmp <- read.bmp(filename[i])
    #   RGB.scale <- pixmapRGB(readbmp)
    #   MR[,i] <- as.numeric(attributes(RGB.scale)$red)
    #   MG[,i] <- as.numeric(attributes(RGB.scale)$green)
    #   MB[,i] <- as.numeric(attributes(RGB.scale)$blue)
    # }
    #
    # n1 <- width*height; n2 <- length(filename)
    #
    # save(MR, MG, MB, n1, n2, width, height, file=paste0(output.naming, "_", main.name, "_", seq.start, "~", seq.end, "_RGB.Rdata"))
  # }

  ## width & height value setting
  if(format=="bmp"){
    read <- read.bmp(wd[1])
  } else if(format %in% c("jpg", "jpeg")){
    read <- readJPEG(wd[1])
  }

  height <- dim(read)[1]
  width <- dim(read)[2]

  ## M matrix space
  M <- matrix(NA, nrow=width*height, ncol=length(wd))

  ## M matrix space <- grey scale pixel value

  if(format == "bmp"){

    pb <- progress_bar$new(total=length(wd))
    for(i in seq(length(wd))){
      pb$tick()
      readbmp <- read.bmp(wd[i])
      grey.scale <- pixmapGrey(readbmp)
      M[, i] <- as.numeric(attributes(grey.scale)$grey)
    }

  } else if(format %in% c("jpg", "jpeg")){

    pb <- progress_bar$new(total=length(wd))
    for(i in seq(length(wd))){
      pb$tick()
      readjp <- readJPEG(wd[i])
      grey.scale <- pixmapGrey(readjp)
      M[, i] <- as.numeric(attributes(grey.scale)$grey)
    }

  }

  ## attributes of `M`
  attr(M, "width") <- width
  attr(M, "height") <- height
  attr(M, "n1") <- width * height
  attr(M, "n2") <- length(wd)

  # return
  assign("M", M, envir = get(save.env))
  if(is.character(output.naming)) save(M, file = paste0(output.naming, ".Rdata"))

}
