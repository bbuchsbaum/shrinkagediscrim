
post_to_tibble <- function(x, object) {
  probs <- x$posterior
  probs <- tibble::as_tibble(probs)
}

get_class <- function(x, object) {
  x$class
}

prob_matrix_to_tibble <- function(x, object) {
  tibble::as_tibble(x)
}



# These functions are tested indirectly when the models are used. Since this
# function is executed on package startup, you can't execute them to test since
# they are already in the parsnip model database. We'll exclude them from
# coverage stats for this reason.

# nocov
make_discrim_shrinkage <- function() {
  parsnip::set_new_model("discrim_shrinkage")

  parsnip::set_model_mode("discrim_shrinkage", "classification")

  # ------------------------------------------------------------------------------

  parsnip::set_model_engine("discrim_shrinkage", "classification", "sda")
  parsnip::set_dependency("discrim_shrinkage", eng = "sda", pkg = "sda")
  parsnip::set_dependency("discrim_shrinkage", eng = "sda", pkg = "shrinkagediscrim")

  parsnip::set_model_arg(
    model = "discrim_shrinkage",
    eng = "sda",
    parsnip = "shrinkage",
    original = "lambda",
    func = list(pkg = "shrinkagediscrim", fun = "shrinkage"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "discrim_shrinkage",
    eng = "sda",
    parsnip = "shrinkage_var",
    original = "lambda.var",
    func = list(pkg = "shrinkagediscrim", fun = "shrinkage_var"),
    has_submodel = FALSE
  )

  parsnip::set_fit(
    model = "discrim_shrinkage",
    eng = "sda",
    mode = "classification",
    value = list(
      interface = "matrix",
      protect = c("data"),
      data=c(x="Xtrain", y="L"),
      func = c(pkg = "sda", fun = "sda"),
      defaults = list()
    )
  )

  parsnip::set_encoding(
    model = "discrim_shrinkage",
    eng = "sda",
    mode = "classification",
    options = list(
      predictor_indicators = "traditional",
      compute_intercept = TRUE,
      remove_intercept = TRUE,
      allow_sparse_x = FALSE
    )
  )

  parsnip::set_pred(
    model = "discrim_shrinkage",
    eng = "sda",
    mode = "classification",
    type = "class",
    value = list(
      pre = NULL,
      post = get_class,
      func = c(fun = "predict"),
      args =
        list(
          object = quote(object$fit),
          newdata = quote(new_data)
        )
    )
  )

  parsnip::set_pred(
    model = "discrim_shrinkage",
    eng = "sda",
    mode = "classification",
    type = "prob",
    value = list(
      pre = NULL,
      post = post_to_tibble,
      func = c(fun = "predict"),
      args =
        list(
          object = quote(object$fit),
          newdata = quote(new_data)
        )
    )
  )

  parsnip::set_pred(
    model = "discrim_shrinkage",
    eng = "sda",
    mode = "classification",
    type = "raw",
    value = list(
      pre = NULL,
      post = NULL,
      func = c(fun = "predict"),
      args =
        list(
          object = quote(object$fit),
          newdata = quote(new_data)
        )
    )
  )

}

