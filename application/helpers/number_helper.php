<?php
defined('BASEPATH') OR exit('No direct access allowed');
function format_number($number) {
    return number_format($number, 0, '.', ' ');
}
?>