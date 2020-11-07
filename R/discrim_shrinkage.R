discrim_shrinkage <-
  function(mode = "classification", shrinkage = NULL, shrinkage_var = NULL) {

    args <- list(
      shrinkage = rlang::enquo(shrinkage),
      shrinkage_var = rlang::enquo(shrinkage_var)
    )

    parsnip::new_model_spec(
      "discrim_shrinkage",
      args = args,
      eng_args = NULL,
      mode = mode,
      method = NULL,
      engine = NULL
    )
  }


#show_model_info("discrim_shrinkage")
