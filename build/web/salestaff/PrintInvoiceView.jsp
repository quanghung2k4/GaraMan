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
                font-family: Arial, sans-serif;
                margin: 40px;
            }

            h1, h3 {
                text-align: center;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 15px;
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

            .customer-info td {
                border: none;
                padding: 4px 8px;
            }
            .customer-info table{
                width: fit-content;
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
            Employee saleStaff = (Employee) session.getAttribute("saleStaff");
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
                        <h3><%=formattedDate%></h3>
                    </td>
                    <td>
                        <p>Mã hóa don: <%=invoice.getId()%></p>      
                    </td>
                </tr>
            </table>
        </div>

        <line/>    
        <!-- Thông tin khách hàng -->
        <div class="customer-info">
            <table >
                <tr>
                    <td><strong>Tên khách hàng:</strong></td>
                    <td><%=  customer.getName()%></td>
                </tr>
                <tr>
                    <td><strong>Số điện thoại:</strong></td>
                    <td><%= customer.getPhone()%></td>
                </tr>
                <tr>
                    <td><strong>Địa chỉ:</strong></td>
                    <td><%= customer.getAddress()%></td>
                </tr>
            </table>
        </div>

        <!-- Chi tiết dịch vụ & phụ tùng -->
        <table>
            <tr>
                <th>STT</th>
                <th>Tên dịch vụ/phụ tùng</th>
                <th>Số lượng</th>
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
                <td class="align-right"><%= String.format("%,.0f", isp.getSparePart().getUnitPrice())%></td>
                <td class="align-right"><%= String.format("%,.0f", isp.getSubTotal())%></td>
            </tr>
            <%
                    }
                }
            %>

            <!-- Tổng cộng -->
            <tr>
                <td colspan="4" class="total">Tổng cộng:</td>
                <td class="align-right"><strong><%= String.format("%,.0f", invoice.getTotalAmount())%></strong></td>
            </tr>
        </table>

        <div style="display: flex; justify-content: center">
            <button class="print-invoice" onclick="printInvoice()">In hóa don</button>

            <button class="print-invoice" onclick="window.location.href = 'salestaff/MainSaleStaffView.jsp'">Tro ve</button>
        </div>
    </body>

</html>
