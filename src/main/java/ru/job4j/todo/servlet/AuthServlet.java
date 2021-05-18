package ru.job4j.todo.servlet;

import ru.job4j.todo.model.User;
import ru.job4j.todo.store.HbmTodoStore;
import ru.job4j.todo.store.Store;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

public class AuthServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        Store store = new HbmTodoStore();
        User user = store.findUserByEmail(email);
        if (user != null && user.getPassword().equals(password)) {
            HttpSession sc = req.getSession();
            User sessionUser = new User(user.getName(), user.getEmail());
            sc.setAttribute("user", sessionUser);
            resp.sendRedirect(req.getContextPath());
        } else {
            resp.setContentType("text/html;charset=UTF-8");
            PrintWriter out = resp.getWriter();
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Не верный email или пароль');");
            out.println("location='login.jsp';");
            out.println("</script>");
        }
    }
}
