<%@page import="model.SaleStaff"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, model.Invoice, model.InvoiceService, model.InvoiceSparePart, model.Customer, model.Employee, dao.InvoiceDAO" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Hóa đơn</title>
        <style>
            body {
                font-family: "Times New Roman", serif;
                margin: 8px;
            }

            h1, h3,h4 {
                text-align: center;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 15px;
                table-layout: fixed;
            }

            th, td {
                border: 1px solid #444;
                padding: 8px;
                text-align: left;
            }

            th {
                text-align: center;
                background-color: #f0f0f0;
            }
            /* Chỉ áp dụng cho bảng có class invoice-table */
            .invoice-table th:nth-child(1),
            .invoice-table td:nth-child(1) {
                width: 3%;
                text-align: center;
            }

            .invoice-table th:nth-child(2),
            .invoice-table td:nth-child(2) {
                width: 40%;
            }

            .invoice-table th:nth-child(3),
            .invoice-table td:nth-child(3) {
                width: 5%;
                text-align: center;
            }

            .invoice-table th:nth-child(4),
            .invoice-table td:nth-child(4) {
                width: 15%;
            }

            .invoice-table th:nth-child(5),
            .invoice-table td:nth-child(5) {
                width: 15%;
            }


            .total {
                text-align: right;
                font-weight: bold;
            }
            .align-center{
                text-align: center;
                width: fit-content;
            }
            .align-right{
                text-align: right;

            }
            .back-btn {
                display: inline;
                margin-top: 25px;
                background-color: #3498db;
                color: #fff;
                text-decoration: none;
                display: flex;
                justify-self: right;
                padding: 10px 18px;
                border-radius: 6px;
                transition: background-color 0.2s ease-in-out;
            }
            .print-invoice{
                margin: 5px;
                background-color: #3498db;
                color: #fff;
                display: flex;
                justify-self: center;
                padding: 10px 18px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
            }
            .customer-info .row {
                display: flex;          /* cho các phần tử con nằm ngang */
                gap: 30px;              /* khoảng cách giữa các mục */
            }
            .customer-info p {
                margin: 4px 0;
            }
            .title table, .title td{
                border: none !important;
            }

        </style>
    </head>

    <script>
        function printInvoice() {
            alert("In hóa đơn thành công!");
            window.location.href = "salestaff/MainSaleStaffView.jsp";
        }
    </script>
    <body>
        <%
            Invoice invoice = (Invoice) session.getAttribute("invoice");
            List<InvoiceService> listServiceInvoice = (List<InvoiceService>) session.getAttribute("listServiceInvoice");
            List<InvoiceSparePart> listSparePartInvoice = (List<InvoiceSparePart>) session.getAttribute("listSparePartInvoice");
            Customer customer = (Customer) session.getAttribute("customer");
            SaleStaff saleStaff = (SaleStaff) session.getAttribute("saleStaff");
            java.util.Date date = invoice.getCreateAt();
            String formattedDate = "";
            if (date != null) {
                SimpleDateFormat dayFormat = new SimpleDateFormat("dd");
                SimpleDateFormat monthFormat = new SimpleDateFormat("MM");
                SimpleDateFormat yearFormat = new SimpleDateFormat("yyyy");
                formattedDate = "Ngày " + dayFormat.format(date)
                        + " tháng " + monthFormat.format(date)
                        + " năm " + yearFormat.format(date);
            }
        %>

        <div class="title">
            <table>
                <tr>
                    <td>
                        <h2>Gara ô tô</h2>     
                        <h2>ABC</h2>     
                    </td>
                    <td>
                        <h1>HÓA ĐƠN</h1>
                        <h4><i><%=formattedDate%></i></dd>
                    </td>
                    <td>
                        <p>Mã hóa đơn: <%=invoice.getId()%></p>      
                    </td>
                </tr>
            </table>
        </div>  
        <!-- Thông tin khách hàng -->
        <div class="customer-info">
            <div class="row">
                <p><b>Tên khách hàng:</b> <%= customer.getName()%></p>
                <p><b>Số điện thoại:</b> <%= customer.getPhone()%></p>
            </div>
            <p><b>Địa chỉ:</b> <%= customer.getAddress()%></p>
        </div>

        <!-- Chi tiết dịch vụ & phụ tùng -->
        <table class="invoice-table">
            <tr>
                <th>STT</th>
                <th>Tên dịch vụ/phụ tùng</th>
                <th>Số lượng</th>
                <th>Loại</th>
                <th>Đơn giá (VNĐ)</th>
                <th>Thành tiền (VNĐ)</th>
            </tr>


            <%
                int i = 1;

                if (listServiceInvoice != null) {
                    for (InvoiceService is : listServiceInvoice) {
            %>
            <tr>
                <td class="align-center"><%= i++%></td>
                <td><%= is.getService().getName()%></td>
                <td class="align-center"><%= is.getNumOfTime()%></td>
                <td>Dịch vụ</td>
                <td class="align-right"><%= String.format("%,.0f", is.getService().getPrice())%></td>
                <td class="align-right"><%= String.format("%,.0f", is.getSubTotal())%></td>
            </tr>
            <%
                    }
                }

                if (listSparePartInvoice != null) {
                    for (InvoiceSparePart isp : listSparePartInvoice) {
            %>
            <tr>
                <td class="align-center"><%= i++%></td>
                <td><%= isp.getSparePart().getName()%></td>
                <td class="align-center"><%= isp.getQuantity()%></td>
                <td>Phụ tùng</td>
                <td class="align-right"><%= String.format("%,.0f", isp.getSparePart().getUnitPrice())%></td>
                <td class="align-right"><%= String.format("%,.0f", isp.getSubTotal())%></td>
            </tr>
            <%
                    }
                }
            %>

            <!-- Tổng cộng -->
            <tr>
                <td colspan="5" class="total">Tổng cộng:</td>
                <td class="align-right"><strong><%= String.format("%,.0f", invoice.getTotalAmount())%></strong></td>
            </tr>
        </table>

        <div style="display: flex; justify-content: center">
            <button class="print-invoice" onclick="printInvoice()">In hóa đơn</button>

            <button class="print-invoice" onclick="window.location.href = 'salestaff/MainSaleStaffView.jsp'">Trở về</button>
        </div>
    </body>

</html>
