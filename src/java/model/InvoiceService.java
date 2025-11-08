package model;

public class InvoiceService {

    private int id;
    private float subTotal;
    private int numOfTime; // số lần dịch vụ được thực hiện
    private Invoice invoice;
    private Service service;

    // ===== Constructors =====
    public InvoiceService() {
    }

    public InvoiceService(int id, float subTotal, int numOfTime, Invoice invoice, Service service) {
        this.id = id;
        this.subTotal = subTotal;
        this.numOfTime = numOfTime;
        this.invoice = invoice;
        this.service = service;
    }

    // ===== Getters and Setters =====
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public float getSubTotal() {
        return subTotal;
    }

    public void setSubTotal(float subTotal) {
        this.subTotal = subTotal;
    }

    public int getNumOfTime() {
        return numOfTime;
    }

    public void setNumOfTime(int numOfTime) {
        this.numOfTime = numOfTime;
    }

    public Invoice getInvoice() {
        return invoice;
    }

    public void setInvoice(Invoice invoice) {
        this.invoice = invoice;
    }

    public Service getService() {
        return service;
    }

    public void setService(Service service) {
        this.service = service;
    }

    // ===== ToString (để debug dễ hơn) =====
    @Override
    public String toString() {
        return "InvoiceService{"
                + "id=" + id
                + ", subTotal=" + subTotal
                + ", numOfTime=" + numOfTime
                + ", invoice=" + (invoice != null ? invoice.getId() : "null")
                + ", service=" + (service != null ? service.getName() : "null")
                + '}';
    }
}
