<%@ page import="java.io.InputStream" %>
<%@ page import="org.apache.ibatis.io.Resources" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactory" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactoryBuilder" %>
<%@ page import="org.apache.ibatis.session.SqlSession" %>
<%@ page import="com.scuec.service.mapper.ShopMapper" %>
<%@ page import="com.scuec.service.Shop" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: YangYang
  Date: 2022/11/1
  Time: 12:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>ๅๅๅ่กจ</title>
    <link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/pricing/">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <style>
        .bd-placeholder-img {
            font-size: 1.125rem;
            text-anchor: middle;
            -webkit-user-select: none;
            -moz-user-select: none;
            user-select: none;
        }

        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
            }
        }

        .b-example-divider {
            height: 3rem;
            background-color: rgba(0, 0, 0, .1);
            border: solid rgba(0, 0, 0, .15);
            border-width: 1px 0;
            box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
        }

        .b-example-vr {
            flex-shrink: 0;
            width: 1.5rem;
            height: 100vh;
        }

        .bi {
            vertical-align: -.125em;
            fill: currentColor;
        }

        .nav-scroller {
            position: relative;
            z-index: 2;
            height: 2.75rem;
            overflow-y: hidden;
        }

        .nav-scroller .nav {
            display: flex;
            flex-wrap: nowrap;
            padding-bottom: 1rem;
            margin-top: -1px;
            overflow-x: auto;
            text-align: center;
            white-space: nowrap;
            -webkit-overflow-scrolling: touch;
        }

        body {
            background-image: linear-gradient(180deg, #eee, #fff 100px, #fff);
        }

        .container {
            max-width: 960px;
        }

        .pricing-header {
            max-width: 700px;
        }

        .shopShow {
            width: 100%;
            height: 800px;
            background-color: aqua;
        }

        /* ่ดญ็ฉ่ฝฆ้จๅ */

        .carBox {
            width: 100px;
            height: 40px;

        }

        .shopCar {
            width: 200px;
            height: 300px;
            background-color: chartreuse;
            position: absolute;
            top: 40px;
            left: -45px;
            display: none;
        }

        .carBox:hover .shopCar {
            display: block;
        }

        /* ๅ่กจๆ?ทๅผๅผๅง */
        .showShop {
            width: 100%;
            height: 800px;
            margin: 0 auto;
            text-align: center;
        }

        .showShop tr {
            border-bottom: 1px solid black;
        }

        .showShop td,
        .showShop th {
            width: 90px;
            height: 90px;
            border-left: 1px solid black;
        }

        .shopBox {
            border: 2px solid black;
            border-radius: 10px;
        }

        .aStyle {
            text-decoration: none;
        }

        /* ๅๅๆ้ฎ */
        .shopButton {
            background-color: aliceblue;
            border: 2px solid black;
            border-radius: 5px;
            font-family: 'ไปฟๅฎ';
            font-weight: 700;
        }

        .shopButton:hover {
            background-color: darkgray;
        }
    </style>
</head>
<body>
<div class="container py-3">
    <header>
        <div class="d-flex flex-column flex-md-row align-items-center pb-3 mb-4 border-bottom">
            <a href="http://localhost:8080/Select.jsp" class="d-flex align-items-center text-dark text-decoration-none">
                <!-- ๅๅๅ็งฐ้จๅ -->
                <span class="fs-4" style="margin-left: 5px;">Buyer Forum</span>
            </a>

            <nav class="d-inline-flex mt-2 mt-md-0 ms-md-auto" style="position: relative;">
                <!-- ่ดญ็ฉ่ฝฆ้จๅ -->
                <div class="carBox">
                    <a class="py-2 text-dark text-decoration-none ifShow" href="#">่ดญ็ฉ่ฝฆ</a>
                    <div class="shopCar"></div>
                </div>
            </nav>
        </div>

        <div class="pricing-header p-3 pb-md-4 mx-auto text-center">
            <h1 class="display-4 fw-normal">Buyer</h1>
            <p class="fs-5 text-muted">่ฏไฟก็ฌฌไธ๏ผ็ๆ็ฌฌไบ<br>ไธไธชๆดๅ?ๅจ้ข็ใๅคๆนไฝ็ใ่ช็ฑ็้่ดญๅนณๅฐ<br>
                ๆฌๅนณๅฐ้ฟๆๆๆถไฟก็จๅๅฎถๅฅ้ฉป
            </p>
        </div>
    </header>


    <div class="shopBox">
        <table class="showShop">
            <tr>
                <th>็ผๅท</th>
                <th>ๅ็งฐ</th>
                <th>ไปทๆ?ผ</th>
                <th>ๆไฝ</th>
            </tr>

            <%
                String resource = "mybatis-config.xml";
                InputStream inputStream = Resources.getResourceAsStream(resource);
                SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
                SqlSession sqlSession = sqlSessionFactory.openSession();
                ShopMapper shopMapper = sqlSession.getMapper(ShopMapper.class);
                List<Shop> shopList = shopMapper.selectShops();
                for (Shop shop : shopList) {
            %>
            <tr>
                <td><%=shop.getId()%>
                </td>
                <td><%=shop.getName()%>
                </td>
                <td><%=shop.getPrice()%>
                </td>
                <td>
                    <button onclick="addCart(<%=shop.getId()%>)">ๅ?ๅฅ่ดญ็ฉ่ฝฆ</button>
                </td>
            </tr>
            <%
                }
            %>
        </table>
    </div>
    <%--็ป็ฎๆ้ฎ--%>
    <div id="app" style="margin-left: 782px;margin-top: 10px">
        <el-button @click="visible = true" onclick="settle()">็ป็ฎ</el-button>
        <el-dialog :visible.sync="visible" title="Hello world">
            <p>Try Element</p>
        </el-dialog>
    </div>


    <h2 class="display-6 text-center mb-4">่ดงๆฏไธๅฎถ</h2>
    <div class="table-responsive">
        <table class="table text-center">
            <thead>
            <tr>
                <th style="width: 34%;"></th>
                <th style="width: 22%;">่ดจ้</th>
                <th style="width: 22%;">ไปทๆ?ผ</th>
                <th style="width: 22%;">ๅฎๅ</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <th scope="row" class="text-start">Buyer Forum</th>
                <td>ๆไฝณ</td>
                <td>ๅฎๆ?</td>
                <td>ๅฅฝ</td>
            </tr>
            <tr>
                <th scope="row" class="text-start">ๅงๅคๅค</th>
                <td>ๆๅพ้ฝๆ</td>
                <td>ๆๅพไธๆผ</td>
                <td>ๆๅพ้ฝๆ</td>
            </tr>
            </tbody>

            <tbody>
            <tr>
                <th scope="row" class="text-start">ๆๅฎ</th>
                <td>ๅคงๅค่ฟ่ก</td>
                <td>็ฅ้ซ</td>
                <td>่ฟ่ก</td>
            </tr>
            <tr>
                <th scope="row" class="text-start">ๆไธ</th>
                <td>่ฟ่ก</td>
                <td>่ฟ่ก</td>
                <td>่ฟ่ก</td>
            </tr>
            </tbody>
        </table>
        <p style="text-align:right;font-size: 15px;">*็บฏๅฑ่็ฎๆๆ๏ผๅๅฟๅฝ็</p>
    </div>


    <footer class="pt-4 my-md-5 pt-md-5 border-top">
        <p style="text-align: center;">&copy;Designed and developed by<a href="https://github.com/ABF7470"
                                                                         class=" aStyle">&nbsp;Yangyang&nbsp;</a>and<a
                href="https://github.com/Qddl925"
                class=" aStyle">&nbsp;Tuo Xiaodong&nbsp;</a>.</p>
    </footer>
</div>
<!-- import Vue before Element -->
<script src="https://unpkg.com/vue@2/dist/vue.js"></script>
<!-- import JavaScript -->
<script src="https://unpkg.com/element-ui/lib/index.js"></script>

<script>
    //็นๅปๅ?ๅฅ่ดญ็ฉ่ฝฆๆ้ฎ๏ผๅฐๅๅidไผ?้็ปๅๅฐ๏ผๅๅฐๅฐๅๅidๅญๅฅsessionไธญ๏ผ้กต้ขไธๅ็่ทณ่ฝฌ
    function addCart(id) {
        var xhr = new XMLHttpRequest();
        xhr.open("get", "/ShopServlet?id=" + id);
        xhr.send();
        xhr.onreadystatechange = function () {
            if (xhr.readyState == 4 && xhr.status == 200) {
                alert("ๅ?ๅฅ่ดญ็ฉ่ฝฆๆๅ");
            }

        }

    }

    //็นๅป็ป็ฎๆ้ฎ๏ผ่ทณ่ฝฌๅฐdoShopping.jsp้กต้ข๏ผๅๅฐๅฐsessionไธญ็ๅๅidๅๅบ๏ผ่ฟ่ก็ป็ฎ
    function settle() {
        window.location.href = "/doShopping.jsp";
    }

</script>
<script>
    new Vue({
        el: '#app',
        data: function() {
            return { visible: false }
        }
    })
</script>
</body>
</html>
