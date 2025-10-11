package model;

public class InvoiceSparePart {
    private int id;
    private int quantity;
    private float unitPrice;
    private float subTotal;
    private Invoice invoice;
    private SparePart sparePart;

    public InvoiceSparePart() {}

    public InvoiceSparePart(int id, int quantity, float unitPrice, float subTotal, Invoice invoice, SparePart sparePart) {
        this.id = id;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.subTotal = subTotal;
        this.invoice = invoice;
        this.sparePart = sparePart;
    }

    // Getter & Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public float getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(float unitPrice) {
        this.unitPrice = unitPrice;
    }

    public float getSubTotal() {
        return subTotal;
    }

    public void setSubTotal(float subTotal) {
        this.subTotal = subTotal;
    }

    public Invoice getInvoice() {
        return invoice;
    }

    public void setInvoice(Invoice invoice) {
        this.invoice = invoice;
    }

    public SparePart getSparePart() {
        return sparePart;
    }

    public void setSparePart(SparePart sparePart) {
        this.sparePart = sparePart;
    }
}
