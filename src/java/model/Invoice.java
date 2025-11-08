package model;

import java.util.Date;

public class Invoice {
    private int id;
    private Date createAt;
    private float totalAmount;
    private String status;
    private SaleStaff salesStaff;   
    private Customer customer;

    public Invoice() {}

    public Invoice(int id, Date date, float totalAmount, String status, SaleStaff salesStaff, Customer customer) {
        this.id = id;
        this.createAt = date;
        this.totalAmount = totalAmount;
        this.status = status;
        this.salesStaff = salesStaff;
        this.customer = customer;
    }

    // Getter & Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Date createAt) {
        this.createAt = createAt;
    }


    public float getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(float totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public SaleStaff getSalesStaff() {
        return salesStaff;
    }

    public void setSalesStaff(SaleStaff salesStaff) {
        this.salesStaff = salesStaff;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }
}
