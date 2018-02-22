//= require jquery3
//= require popper
//= require bootstrap
//= require rails-ujs
//= require turbolinks
//= require datatables
//= require_tree .

$(document).ready( function () {
    $('#sv-table').DataTable({
      "bPaginate": false,
      "columnDefs": [
        { "orderable": false, "targets": -1 }
      ],
      "oLanguage": {
        "sInfo": "_TOTAL_ servers"
      }
    });
} );
