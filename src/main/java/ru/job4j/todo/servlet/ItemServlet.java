package ru.job4j.todo.servlet;

import com.google.gson.Gson;
import ru.job4j.todo.model.Item;
import ru.job4j.todo.store.HbmTodoStore;
import ru.job4j.todo.store.Store;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Collection;

public class ItemServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Store store = new HbmTodoStore();
        Collection<Item> items = store.findAllItems();
        String json = new Gson().toJson(items);
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        resp.getWriter().write(json);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if ("add".equals(req.getParameter("action"))) {
            req.setCharacterEncoding("UTF-8");
            String description = req.getParameter("description");
            Store store = new HbmTodoStore();
            Item item = new Item(description, new Timestamp(System.currentTimeMillis()), false);
            store.addItem(item);
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("index.jsp");
            requestDispatcher.forward(req, resp);
        } else {
            int itemId = Integer.parseInt(req.getParameter("itemId"));
            Store store = new HbmTodoStore();
            Item item = store.findById(itemId);
            if (!item.isDone()) {
                item.setDone(true);
            } else {
                item.setDone(false);
            }
            store.replace(item);
        }
    }
}
