<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
    <div class="p-3">
      <h5>Title</h5>
      <p>Sidebar content</p>
      <a href="<c:url value='/uat/uia/actionLogout.do'/>" class="btn btn-primary btn-lg btn-block">로그아웃</a>
    </div>
  </aside>
  
  <!-- /.control-sidebar -->

  <!-- Main Footer -->
  <footer class="main-footer">
    <!-- To the right -->
    <div class="float-right d-none d-sm-inline">
      Anything you want
    </div>
    <!-- Default to the left -->
    <strong>Copyright &copy; 2014-2020 <a href="https://adminlte.io">AdminLTE.io</a>.</strong> All rights reserved.
  </footer>


<!-- REQUIRED SCRIPTS -->

<!-- jQuery -->
<script src="<c:url value='/'/>plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="<c:url value='/'/>plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="<c:url value='/'/>dist/js/adminlte.min.js"></script>
<script>
$(document).ready(function() {//location.pathname현재 페이지의 파일이름, 경로를 리턴해준다
    var current = location.pathname;
    //alert(current.split("/admin",3)[1]); //디버그 값
    var current_split = current.split("/admin",3)[1]; // board 또는  member
    $(".nav-treeview li a").each(function(){
        var $this = $(this);//가독성을 위해서 
        if(current=="/admin" || current=="/admin/") {
           
        }else{//attr()을 통해서는  element가 가지는 속성값이나 정보를 조회(style,src)하거나세텅하는 형식의업무. prop()을통해서는 element가 가지는 실제적인 상태(활성화,체크,선택여부)를 제어하는 업무를하는것이좋다
        //if($this.attr('href').includes(current) == true){
        if($this.attr('href').indexOf(current_split) != -1){
            $this.addClass('active');
        }else{
           $this.removeClass('active');
        }
    });
 });
</script>
</body>
</html>