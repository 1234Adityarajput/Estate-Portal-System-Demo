<?php 
// Safe count helper to avoid fatal PHP 8.x errors on bool
function safe_count($conn, $sql) {
    if (!$conn || !($conn instanceof mysqli) || $conn->connect_error) return 0;
    $res = @$conn->query($sql);
    if ($res && $res instanceof mysqli_result) {
        $count = $res->num_rows;
        $res->free();
        return $count;
    }
    return 0;
}

$agent_id = (int)($_settings->userdata('id') ?: 0);
$available_count = safe_count($conn, "SELECT id FROM real_estate_list where agent_id = {$agent_id} and `status` = 1");
$unavailable_count = safe_count($conn, "SELECT id FROM real_estate_list where agent_id = {$agent_id} and `status` = 2");
?>
<h1>Welcome to <?php echo $_settings->info('name') ?: 'Real Estate Portal System' ?></h1>
<hr>
<div class="row">
    <div class="col-12 col-sm-6 col-md-6">
      <div class="info-box shadow-sm">
        <span class="info-box-icon bg-gradient-teal elevation-1"><i class="fas fa-map-marker-alt"></i></span>
        <div class="info-box-content">
          <span class="info-box-text">Available</span>
          <span class="info-box-number">
            <?php echo format_num($available_count); ?>
          </span>
        </div>
      </div>
    </div>
    
    <div class="col-12 col-sm-6 col-md-6">
      <div class="info-box shadow-sm">
        <span class="info-box-icon bg-gradient-maroon elevation-1"><i class="fas fa-map-marker-alt"></i></span>
        <div class="info-box-content">
          <span class="info-box-text">Unavailable</span>
          <span class="info-box-number">
            <?php echo format_num($unavailable_count); ?>
          </span>
        </div>
      </div>
    </div>
</div>

<div class="container mt-3">
  <?php 
    $files = array();
    $banner_path = base_app . 'uploads/banner';
    if (is_dir($banner_path)) {
      $fopen = @scandir($banner_path);
      if ($fopen) {
        foreach ($fopen as $fname) {
          if (in_array($fname, array('.', '..')))
            continue;
          $files[] = validate_image('uploads/banner/' . $fname);
        }
      }
    }
  ?>
  <?php if (!empty($files)): ?>
  <div id="tourCarousel" class="carousel slide shadow" data-ride="carousel" data-interval="3000">
      <div class="carousel-inner h-100">
          <?php foreach ($files as $k => $img): ?>
          <div class="carousel-item h-100 <?php echo $k == 0 ? 'active' : '' ?>">
              <img class="d-block w-100 h-100" style="object-fit:cover; max-height:400px;" src="<?php echo $img ?>" alt="">
          </div>
          <?php endforeach; ?>
      </div>
      <a class="carousel-control-prev" href="#tourCarousel" role="button" data-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="sr-only">Previous</span>
      </a>
      <a class="carousel-control-next" href="#tourCarousel" role="button" data-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="sr-only">Next</span>
      </a>
  </div>
  <?php endif; ?>
</div>
