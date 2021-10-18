<html>
<head>
    <link rel="icon" href="design/themes/responsive/css/addons/jmj_digital/static-pages-final/images/fevicon.png" sizes="64x64" type="image/png">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
        rel="stylesheet">
    <!--<link rel="stylesheet" href="design/themes/responsive/css/addons/jmj_digital/static-pages-final/css/bootstrap.min.css">-->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="design/themes/responsive/css/addons/jmj_digital/static-pages-final/css/style.css">
    <link rel="stylesheet" href="design/themes/responsive/css/addons/jmj_digital/static-pages-final/css/responsive.css">
</head>
<body>
<div>
    {hook name="pages:page_content"}
    <div {live_edit name="page:description:{$page.page_id}"}>{$page.description nofilter}</div>
    {/hook}
</div>
    
{hook name="pages:page_extra"}
{/hook}
</body>
</html>