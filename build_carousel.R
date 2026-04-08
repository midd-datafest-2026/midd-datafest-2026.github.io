imgs <- list.files("images/datafest2025", pattern = "\\.jpg$", full.names = FALSE)
imgs <- sort(imgs)

indicators <- mapply(function(img, i) {
  active <- if (i == 0) 'class="active" aria-current="true" ' else ''
  sprintf(
    '<button type="button" data-bs-target="#datafest2025Carousel" data-bs-slide-to="%d" %saria-label="Slide %d"></button>',
    i, active, i + 1
  )
}, imgs, seq_along(imgs) - 1)

items <- mapply(function(img, i) {
  active <- if (i == 1) " active" else ""
  sprintf(
    '<div class="carousel-item%s">
  <img src="images/datafest2025/%s" class="d-block w-100" alt="DataFest 2025">
</div>',
    active, img
  )
}, imgs, seq_along(imgs))

thumbnails <- mapply(function(img, i) {
  active_class <- if (i == 0) " thumb-active" else ""
  sprintf(
    '<img src="images/datafest2025/%s" class="carousel-thumb%s" data-bs-target="#datafest2025Carousel" data-bs-slide-to="%d" alt="Thumbnail %d">',
    img, active_class, i, i + 1
  )
}, imgs, seq_along(imgs) - 1)

html <- sprintf('
<div id="datafest2025Carousel" class="carousel slide" data-bs-ride="carousel" data-bs-interval="3000">
  <div class="carousel-indicators">
    %s
  </div>
  <div class="carousel-inner">
    %s
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#datafest2025Carousel" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#datafest2025Carousel" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>

<div class="carousel-thumbnails">
  %s
</div>

<script>
  const carouselEl = document.getElementById("datafest2025Carousel");
  const thumbs = document.querySelectorAll(".carousel-thumb");

  carouselEl.addEventListener("slid.bs.carousel", function(e) {
    thumbs.forEach(t => t.classList.remove("thumb-active"));
    thumbs[e.to].classList.add("thumb-active");
  });
</script>
',
                paste(indicators, collapse = "\n    "),
                paste(items, collapse = "\n    "),
                paste(thumbnails, collapse = "\n  "))

writeLines(html, "datafest2025_carousel.html")