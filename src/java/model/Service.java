
package model;

/**
 *
 * @author ADMIN
 */
public class Service {
    private int id;
    private String name;
    private int numOfStaff;
    private float duration;
    private String description;
    private double price;
    
    
    public Service() {
        
    }

    public Service(int id, String name, String description, double price) {
        this.id = id;
        this.name =name;
        this.description=description;
        this.price=price;
    }

    

    public int getNumOfStaff() {
        return numOfStaff;
    }

    public void setNumOfStaff(int numOfStaff) {
        this.numOfStaff = numOfStaff;
    }

    public float getDuration() {
        return duration;
    }

    public void setDuration(float duration) {
        this.duration = duration;
    }
    

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
}
