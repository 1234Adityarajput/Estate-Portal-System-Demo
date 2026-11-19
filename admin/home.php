<?php 
// Check if REPS core tables exist in database
$tables_check = ($conn && $conn instanceof mysqli && !$conn->connect_error) ? @$conn->query("SHOW TABLES LIKE 'real_estate_list'") : false;
$has_reps_tables = ($tables_check && $tables_check instanceof mysqli_result && $tables_check->num_rows > 0);

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

$types_count = safe_count($conn, "SELECT id FROM type_list where delete_flag = 0");
$amenities_count = safe_count($conn, "SELECT id FROM amenity_list where delete_flag = 0");
$available_count = safe_count($conn, "SELECT id FROM real_estate_list where status = 1");
$unavailable_count = safe_count($conn, "SELECT id FROM real_estate_list where status = 2");
?>

<h1>Welcome to <?php echo $_settings->info('name') ?: 'Real Estate Portal System' ?></h1>
<hr>

<?php if (!$has_reps_tables): ?>
<div class="alert alert-warning shadow-sm mb-4">
  <h5><i class="fas fa-exclamation-triangle mr-2"></i> Real Estate Database Schema Not Detected!</h5>
  <p class="mb-2">The connected database does not contain the required tables (such as <code>real_estate_list</code>, <code>type_list</code>, <code>amenity_list</code>). Please initialize the database with 1 click.</p>
  <a href="<?php echo base_url ?>db_setup.php" class="btn btn-primary btn-sm"><i class="fas fa-database mr-1"></i> Open 1-Click Database Setup</a>
</div>
<?php endif; ?>

<div class="row">
    <div class="col-12 col-sm-6 col-md-6">
        <div class="info-box shadow-sm">
          <span class="info-box-icon bg-gradient-primary elevation-1"><i class="fas fa-list"></i></span>
          <div class="info-box-content">
            <span class="info-box-text">Real Estate Types</span>
            <span class="info-box-number">
              <?php echo format_num($types_count); ?>
            </span>
          </div>
        </div>
    </div>

    <div class="col-12 col-sm-6 col-md-6">
        <div class="info-box shadow-sm">
          <span class="info-box-icon bg-gradient-light elevation-1"><i class="fas fa-star"></i></span>
          <div class="info-box-content">
            <span class="info-box-text">Total Amenities</span>
            <span class="info-box-number">
              <?php echo format_num($amenities_count); ?>
            </span>
          </div>
        </div>
    </div>

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
