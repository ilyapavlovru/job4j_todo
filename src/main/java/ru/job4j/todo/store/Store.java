package ru.job4j.todo.store;

import ru.job4j.todo.model.Category;
import ru.job4j.todo.model.Item;
import ru.job4j.todo.model.Role;
import ru.job4j.todo.model.User;

import java.util.Collection;

public interface Store {
    Collection<Item> findAllItems();
    Collection<Category> findAllCategories();
    Item addItem(Item item, String[] ids);
    Item findItemById(int id);
    boolean replaceItem(Item item);
    User findUserByEmail(String email);
    User addUser(User user);
    Role findRoleByName(String name);
    Role addRole(Role role);
}
