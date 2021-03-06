% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/operator.R
\name{Singular_value_thresholding_operator}
\alias{Singular_value_thresholding_operator}
\title{Singular value thresholding operator function}
\usage{
Singular_value_thresholding_operator(tau, x)
}
\description{
Singular value thresholding operator function
}
\details{
본 함수는 \code{Shrinkage.operator}, \code{corpcor::fast.svd()} 함수를 이용합니다.
따라서 corpcor package 종속입니다.
}
\seealso{
\link{fast.svd}
}
