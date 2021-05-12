package ru.job4j.todo.store;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import ru.job4j.todo.model.Item;
import ru.job4j.todo.model.Role;
import ru.job4j.todo.model.User;

import java.util.Collection;
import java.util.function.Function;

public class HbmTodoStore implements Store, AutoCloseable {
    private final StandardServiceRegistry registry = new StandardServiceRegistryBuilder()
            .configure().build();
    private final SessionFactory sf = new MetadataSources(registry)
            .buildMetadata().buildSessionFactory();

    private <T> T tx(final Function<Session, T> command) {
        try (Session session = sf.openSession()) {
            session.beginTransaction();
            T rsl = command.apply(session);
            session.getTransaction().commit();
            return rsl;
        }
    }

    @Override
    public Collection<Item> findAllItems() {
        return tx(
                session -> session.createQuery("from ru.job4j.todo.model.Item").list()
        );
    }

    @Override
    public Item addItem(Item item) {
        return tx(
                session -> {
                    session.save(item);
                    return item;
                }
        );
    }

    @Override
    public Item findItemById(int id) {
        return tx(
                session -> session.get(Item.class, id)
        );
    }

    @Override
    public boolean replaceItem(Item item) {
        return tx(
                session -> {
                    session.update(item);
                    return true;
                }
        );
    }

    @Override
    public User findUserByEmail(String email) {
//
//        try (Session session = sf.openSession()) {
//            session.beginTransaction();
//            Query query = session.createQuery("from ru.job4j.todo.model.User where email = :email");
//            query.setParameter("email", email);
//            User result = (User) query.uniqueResult();
//            session.getTransaction().commit();
//            return result;
//        }

        return tx(
                session -> {
                    Query query = session.createQuery("from ru.job4j.todo.model.User where email = :email");
                    query.setParameter("email", email);
                    return (User) query.uniqueResult();
                }
        );
    }

    @Override
    public User addUser(User user) {
        return tx(
                session -> {
                    session.save(user);
                    return user;
                }
        );
    }

    @Override
    public Role findRoleByName(String name) {
        return tx(
                session -> {
                    Query query = session.createQuery("from ru.job4j.todo.model.Role where name = :name");
                    query.setParameter("name", name);
                    return (Role) query.uniqueResult();
                }
        );
    }

    @Override
    public Role addRole(Role role) {
        return tx(
                session -> {
                    session.save(role);
                    return role;
                }
        );
    }

    @Override
    public void close() throws Exception {
        StandardServiceRegistryBuilder.destroy(registry);
    }
}
