library(reticulate)
library(testthat)

reticulate::use_condaenv("r-reticulate")
# install_nltk()
# get_nltk_data()
test_that("`get_syns` returns a character vector of length 1",{
  expect_equal(
    object = get_translation(token = "missile", part_of_speech =  "n", language = "jpn" ),
    expected =   "ミサイル || 弾丸"
    )

  expect_equal(object = get_translation(token = "cymbal", part_of_speech =  "v", language = "jpn" ),
               expected = NA_character_)
  })

test_that("`get_translation` can handle non-character inputs to token",{
  expect_equal(
    object = get_translation(token = 1, part_of_speech = "a", language = "jpn"),
    expected = ""
  )

})



test_that("`get_syns` throws a useful error when a non-language is passed to `language`",{
  expect_error(object = get_translation(token = "missile", part_of_speech =  "v", language = "GERMAN")
               )
})


