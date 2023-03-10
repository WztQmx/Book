<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>图书管理</title>
    <%-- 静态引入头部的css jQuery base 标签 信息--%>
    <%@include file="/pages/common/head.jsp" %>
</head>
<body>

<div id="header">
    <img class="logo_img" alt="" src="static/img/logo.gif">
    <span class="wel_word">图书管理系统</span>
    <%-- 静态引入管理界面相同的菜单--%>
    <%@include file="/pages/common/manager_menu.jsp" %>
</div>

<div id="main">
    <table>
        <tr>
            <td>名称</td>
            <td>价格</td>
            <td>作者</td>
            <td>销量</td>
            <td>库存</td>
            <td colspan="2">操作</td>
        </tr>
        <c:forEach items="${requestScope.page.items}" var="book">
            <tr>
                <td>${book.name}</td>
                <td>${book.price}</td>
                <td>${book.author}</td>
                <td>${book.sales}</td>
                <td>${book.stock}</td>
                <td><a href="manager/bookServlet?action=getBook&id=${book.id}">修改</a></td>
                <td><a class="deleteClass" onclick="fn();" href="manager/bookServlet?action=delete&id=${book.id}">删除</a>
                </td>
            </tr>
        </c:forEach>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td><a href="pages/manager/book_edit.jsp">添加图书</a></td>
        </tr>
    </table>
    <div id="page_nav">
        <c:if test="${requestScope.page.pageNo > 1}">
            <a href="manager/bookServlet?action=page&pageNo=1">首页</a>
            <a href="manager/bookServlet?action=page&pageNo=${requestScope.page.pageNo - 1}">上一页</a>
        </c:if>
        <a href="#">3</a>
        【${requestScope.page.pageNo}】
        <a href="#">5</a>
        <%--如果已经是最后一页, 则不显示下一页, 末页--%>
        <c:if test="${requestScope.page.pageNo < requestScope.page.pageTotal}">
            <a href="manager/bookServlet?action=page&pageNo=${requestScope.page.pageNo + 1}">下一页</a>
            <a href="manager/bookServlet?action=page&pageNo=${requestScope.page.pageTotal}">末页</a>
        </c:if>
        共${requestScope.page.pageTotal}页，${requestScope.page.pageTotalCount}条记录 到第<input value="${param.pageNo}" name="pn"
                                                                                         id="pn_input"/>页
        <input id="searchPageBtn" type="button" value="确定">
        <script type="text/javascript">
            window.onload = function () {
                let pageNo = document.querySelector("#pn_input").value;
                const btnObj = document.querySelector("#searchPageBtn");
                if (pageNo < 1) {
                    pageNo = 1;
                }
                <%--alert(${requestScope.page.pageTotal});--%>
                if (pageNo > ${requestScope.page.pageTotal}) {
                    pageNo = ${requestScope.page.pageTotal};
                }
                btnObj.onclick = function () {
                    location.href = "http://localhost:8080/bookJavaEE/manager/bookServlet?action=page&pageNo=" + pageNo;
                }
            }
        </script>
    </div>
</div>
<script type="text/javascript">
    // 给删除的 a 标签添加单击事件, 用于删除的确认提示操作
    /**
     * confirm 是确认提示框函数
     * 参数是它的提示内容
     * 它有两个按钮, 一个是确认, 一个是取消
     * 返回 true 表示点击了确认, 返回 false 表示点击了取消
     * @returns {boolean}
     */
    function fn() {
        const deleteObj = document.querySelector(".deleteClass");
        deleteObj.onclick = function () {
            return confirm("你确定要删除【" + this.parent().parent().firstChild + "】？");
        }

    }
</script>
<%-- 静态引入页脚信息 --%>
<%@include file="/pages/common/footer.jsp" %>
</body>
</html>