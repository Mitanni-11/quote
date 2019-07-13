$(document).on('turbolinks:load', function (){
    $(document).on('keyup', '#search_form', function(e){
        e.preventDefault();
        var input = $.trim($(this).val());
        $.ajax({
            url: '/search',
            type: 'GET',
            date: ('keyward' +input),
            processData: false, //おまじない
            contentType: false, //おまじない
            dataType: 'json' //データ形式を指定

        })
    })
});