public class Bicycle {

 //States
private String type;
private int maxSpeed;


 //Constructor
public Bicycle(String type, int maxSpeed) {
this.type = type;
this.maxSpeed = maxSpeed;
}
 //Copy-Constructor
public Bicycle(Bicycle copy) {
type = copy.type;
maxSpeed = copy.maxSpeed;
}


 //Get Methods
public String getType() { return type; }
public int getMaxspeed() { return maxSpeed; }


 //Set Methods
public setType(String type) { this.type = type; }
public setMaxspeed(int maxSpeed) { this.maxSpeed = maxSpeed; }


 //ToString Method
public String toString() {
return type + " " + maxSpeed;
}

}
