#' @export
confint.margins <- 
function(object, parm, level = 0.95, ...) {
    pnames <- colnames(object$Effect)
    if (missing(parm)) {
        parm <- pnames
    } else if (is.numeric(parm))  {
        parm <- pnames[parm]
    }
    cf <- colMeans(object$Effect)[parm]
    a <- (1 - level)/2
    a <- c(a, 1 - a)
    fac <- qnorm(a)
    ci <- array(NA, dim = c(length(parm), 2L), dimnames = list(parm, a))
    ses <- sqrt(object$Variance)
    ci[] <- cf + ses %o% fac
    colnames(ci) <- sprintf("%0.2f%%", 100 * a)
    ci
}