<%namespace file="functions/brand.mak" import="brand" />
<%namespace file="functions/navigation.mak" import="make_navigation" />

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" href="${request.static_url('particledb:static/img/favicon.png')}">

        <title>
            <%block name="title" />
            Particle
        </title>

        <link href="${request.static_url('particledb:static/css/dist/bootstrap/bootstrap.min.css')}" rel="stylesheet">
        <link href="${request.static_url('particledb:static/css/dist/typeahead.js/theme.css')}" rel="stylesheet">
        <link href="${request.static_url('particledb:static/css/dist/xeditable/bootstrap-editable.css')}" rel="stylesheet">
        <link href="${request.static_url('particledb:static/css/main.css')}" rel="stylesheet">

        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
    </head>
    <body>
        <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="${request.route_path('home')}">${brand()}</a>
                </div>
                <div id="navbar" class="navbar-collapse collapse">
                    <form class="navbar-form navbar-left" id="search">
                        <input type="text" class="form-control typeahead" id="globalsearchinput" placeholder="Search...">
                    </form>
                </div>
            </div>
        </nav>

        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-3 col-md-2 sidebar">
                    ${make_navigation(view.navigation())}
                </div>
                <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                    ${next.body()}
                </div>
            </div>
        </div>

        <script>
            var js_globals = {
                search_prefetch_url: "${request.route_path('search_prefetch')}",
                search_dest_url: "${request.route_path('part', part_mpn="__mpn__")}",
                add_part_url: "${request.route_path('add_part')}",
                mpn_check_url: "${request.route_path('mpn_check')}",
                manufacturers_prefetch_url: "${request.route_path('manufacturers_prefetch')}",
                descriptions_prefetch_url: "${request.route_path('descriptions_prefetch')}",
                parameter_remove_url: "${request.route_path('parameter_remove')}",
                parameter_add_url: "${request.route_path('parameter_add')}",
                parameter_reorder_url: "${request.route_path('parameter_reorder')}",
                storage_add_url: "${request.route_path('storage_add')}",
                storage_url: "${request.route_path('storage')}",
                delete_file_url: "${request.route_path('delete_file')}",
                octopart_search_url: "${request.route_path('octopart_search')}",
            };
        </script>
        <script src="${request.static_url('particledb:static/js/dist/jquery/jquery-1.11.2.min.js')}"></script>
        <script src="${request.static_url('particledb:static/js/dist/jquery.fileupload/jquery.ui.widget.js')}"></script>
        <script src="${request.static_url('particledb:static/js/dist/jquery.fileupload/jquery.iframe-transport.js')}"></script>
        <script src="${request.static_url('particledb:static/js/dist/jquery.fileupload/jquery.fileupload.js')}"></script>
        <script src="${request.static_url('particledb:static/js/dist/jquery.hotkeys.js/jquery.hotkeys.js')}"></script>
        <script src="${request.static_url('particledb:static/js/dist/typeahead.js/typeahead.bundle.js')}"></script>
        <script src="${request.static_url('particledb:static/js/dist/bootstrap/bootstrap.min.js')}"></script>
        <script src="${request.static_url('particledb:static/js/dist/bootbox.js/bootbox.min.js')}"></script>
        <script src="${request.static_url('particledb:static/js/dist/xeditable/bootstrap-editable.min.js')}"></script>
        <script src="${request.static_url('particledb:static/js/search.js')}"></script>
        <%block name="javascript" />
        <script>
            $.fn.editable.defaults.mode = 'inline';
            $.fn.editable.defaults.onblur = 'submit';
            $(function () {
                $('[data-toggle="tooltip"]').tooltip()
            });
            $(document).bind('keyup', 'f', function() {
                $('#globalsearchinput').focus();
            });
            /* enable drop zone effects */
            $(document).bind('dragover', function (e) {
                var dropZone = $('#dropzone'),
                    timeout = window.dropZoneTimeout;
                if (!timeout) {
                    dropZone.addClass('in');
                } else {
                    clearTimeout(timeout);
                }
                var found = false,
                    node = e.target;
                do {
                    if (node === dropZone[0]) {
                        found = true;
                        break;
                    }
                    node = node.parentNode;
                } while (node != null);
                if (found) {
                    dropZone.addClass('hover');
                } else {
                    dropZone.removeClass('hover');
                }
                window.dropZoneTimeout = setTimeout(function () {
                    window.dropZoneTimeout = null;
                    dropZone.removeClass('in hover');
                }, 100);
            });
            /* Prevent the default browser drop action */
            $(document).bind('drop dragover', function (e) {
                e.preventDefault();
            });
        </script>
    </body>
</html>
