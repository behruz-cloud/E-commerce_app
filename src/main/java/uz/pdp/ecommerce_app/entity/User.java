package uz.pdp.ecommerce_app.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
    private Integer id=idGen++;
    private String firstName;
    private String lastName;
    private String phoneNumber;
    private String password;
    private Role role;
    private static Integer idGen = 0;

    public User(String firstName, String lastName, String phoneNumber, String password, Role role) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.phoneNumber = phoneNumber;
        this.password = password;
        this.role = role;
    }
}
