package ru.job4j.todo.model;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;

@Entity
@Table(name = "item")
public class Item {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String description;

    @Temporal(TemporalType.TIMESTAMP)
    private Date created;

    private boolean done;

    @Column(name = "user_name")
    private String userName;

    @ManyToMany(cascade = {CascadeType.PERSIST, CascadeType.MERGE}, fetch = FetchType.LAZY)
    private List<Category> categories = new ArrayList<>();

    public void addCategory(Category category) {
        this.categories.add(category);
    }

    public Item() {
    }

    public Item(String description, boolean done, String userName) {
        this.description = description;
        this.created = new Date(System.currentTimeMillis());
        this.done = done;
        this.userName = userName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getCreated() {
        return created;
    }

    public void setCreated(Date created) {
        this.created = created;
    }

    public boolean isDone() {
        return done;
    }

    public void setDone(boolean done) {
        this.done = done;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        Item item = (Item) o;
        return Objects.equals(id, item.id)
                && Objects.equals(description, item.description);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, description);
    }

    @Override
    public String toString() {
        return "{"
                + "id='" + id + '\''
                + ", description='" + description + '\''
                + '}';
    }
}
