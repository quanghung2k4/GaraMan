
package model;

public class SparePart {
    private int id;
    private String name;
    private int quanity;
    private int soldNum;
    private float unitPrice;
    private String description;

    public SparePart(int id, String name, int quanity, int soldNum, float unitPrice, String description) {
        this.id = id;
        this.name = name;
        this.quanity = quanity;
        this.soldNum = soldNum;
        this.unitPrice = unitPrice;
        this.description = description;
    }

    public SparePart() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getQuanity() {
        return quanity;
    }

    public void setQuanity(int quanity) {
        this.quanity = quanity;
    }

    public int getSoldNum() {
        return soldNum;
    }

    public void setSoldNum(int soldNum) {
        this.soldNum = soldNum;
    }

    public float getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(float unitPrice) {
        this.unitPrice = unitPrice;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
}
