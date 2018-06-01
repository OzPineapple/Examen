package Dao;

import Clases.Carro;
import Clases.Item;
import Clases.Sesion;
import Clases.Usuario;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDao {
    //Conexion con la BD
    public static Connection getConnection(){
        String url, UserName, password;
        url="jdbc:mysql:3306//localhost/examen";
        UserName="root";
        password="n0m3l0";
        
        Connection con=null;
        
        try{
            Class.forName("com.mysql.jdbc.Driver");
            url="jdbc:mysql://localhost/examen";
            con=DriverManager.getConnection(url, UserName, password);
            
            System.out.println("Si se conecto a la BD");
        }catch(Exception e){
            System.out.println("No hay conexion...");
            System.out.println(e.getMessage());
            System.out.println(e.getStackTrace());
        }
        return con;
    }
    //Comprueba que la contrasena sea igual al password y devuelve un booleano
    public static boolean comprobarPassByEmail(String user,String password){
        boolean igual=false;
        String pass = "";        
        try{
            Connection con=UsuarioDao.getConnection();
            String q;
            q="SELECT pass FROM user WHERE user=?";

            PreparedStatement ps=con.prepareStatement(q);
            ps.setString(1, user);
            
            ResultSet rs=ps.executeQuery();
            
            if (rs.next()) {
                pass=rs.getString(1);
                igual=pass.equals(password);
            }            
            
            System.out.println("Conexion exitosa... (comprobarPassByEmail)");
            
            con.close();        
        }catch(Exception d){
            System.out.println("No hay conexion... (comprobarPassByEmail)");
            System.out.println(d.getMessage());
            System.out.println(d.getStackTrace());
        }
        return igual;
    }
    //Obtiene el id_tipo del Usuario y lo devuelve
    public static int getId_TipoByEmail(String user){
        int id_tipo=0;       
        try{
            Connection con=UsuarioDao.getConnection();
            String q;
            q="SELECT id_tipo FROM user WHERE user=?";

            PreparedStatement ps=con.prepareStatement(q);
            ps.setString(1, user);
            
            ResultSet rs=ps.executeQuery();
            
            if (rs.next()) {
                id_tipo=rs.getInt(1);
            }            
            
            System.out.println("Conexion exitosa... (getId_TipoByEmail)");
            
            con.close();        
        }catch(Exception d){
            System.out.println("No hay conexion... (getId_TipoByEmail)");
            System.out.println(d.getMessage());
            System.out.println(d.getStackTrace());
        }
        return id_tipo;
    }
    //Obtiene la sesion del usuario
    public static Sesion getSesionUser(String user){
        Sesion e = new Sesion();
                
        try{
            Connection con=UsuarioDao.getConnection();
            String q;
            q="SELECT id_us,user,id_tipo "
                + "FROM user "
                + "WHERE user=?";

            PreparedStatement ps=con.prepareStatement(q);
            ps.setString(1, user);
            
            ResultSet rs=ps.executeQuery();
            if (rs.next()) {
                e.setId_us(rs.getInt(1));
                e.setUser(rs.getString(2));
            }

            System.out.println("Conexion exitosa... (getSesionUser)");
            
            con.close();        
        }catch(Exception d){
            System.out.println("No hay conexion... (getSesionUser)");
            System.out.println(d.getMessage());
            System.out.println(d.getStackTrace());
        }
        return e;
    }
    //Agrega un usuario de tipo segun su id
    public static int AgregarUsuario(Usuario e,int id_tipo){
        int estatus=0;        
        try{
            Connection con=UsuarioDao.getConnection();
            String q;
            q="INSERT INTO user(user,pass,id_tipo) VALUES(?,?,?)";

            PreparedStatement ps=con.prepareStatement(q);
            ps.setString(1, e.getUser());
            ps.setString(2, e.getPass());
            ps.setInt(3, id_tipo);
            estatus=ps.executeUpdate();
            
            System.out.println("Conexion exitosa... (AgregarUsuario)");
            
            con.close();
        
        }catch(Exception d){
            System.out.println("No hay conexion... (AgregarUsuario)");
            System.out.println(d.getMessage());
            System.out.println(d.getStackTrace());
        }
        return estatus;
    }
    //Elimina si existe la tabla items
    public static int DropTableItems(){
        int estatus=0;        
        try{
            Connection con=UsuarioDao.getConnection();
            String q;
            q="DROP TABLE IF EXISTS items";

            PreparedStatement ps=con.prepareStatement(q);
            estatus=ps.executeUpdate();
            
            System.out.println("Conexion exitosa... (DropTableItems)");
            
            con.close();
        
        }catch(Exception d){
            System.out.println("No hay conexion... (DropTableItems)");
            System.out.println(d.getMessage());
            System.out.println(d.getStackTrace());
        }
        return estatus;
    }
    //Crea la vista para cuando el usuario acaba de iniciar sesion
    public static int CreateViewItems1(){
        int estatus=0;        
        try{
            Connection con=UsuarioDao.getConnection();
            String q;
            q="CREATE TABLE items AS SELECT * FROM item";

            PreparedStatement ps=con.prepareStatement(q);
            estatus=ps.executeUpdate();
            
            System.out.println("Conexion exitosa... (CreateViewItems1)");
            
            con.close();
        
        }catch(Exception d){
            System.out.println("No hay conexion... (CreateViewItems1)");
            System.out.println(d.getMessage());
            System.out.println(d.getStackTrace());
        }
        return estatus;
    }
    //Obtiene todos los Items (Solo para el Admin)
    public static List<Item> getAllItems(){
        List<Item> lista=new ArrayList<Item>();
        
        try{
            Connection con=UsuarioDao.getConnection();
            String q;
            q="SELECT * FROM item";
            
            PreparedStatement ps=con.prepareStatement(q);
            
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                Item e=new Item();
                e.setId_item(rs.getInt(1));
                e.setItem(rs.getString(2));
                e.setStock(rs.getInt(3));
                e.setCosto(rs.getDouble(4));
                lista.add(e);
            }            
            
            System.out.println("Conexion exitosa... (getAllItems)");
            
            con.close();        
        }catch(Exception d){
            System.out.println("No hay conexion... (getAllItems)");
            System.out.println(d.getMessage());
            System.out.println(d.getStackTrace());
        }
        return lista;
    }
    
    //Obtiene todos los items de la vista(Solo para el usuario)
    public static List<Item> getAllItems1(){
        List<Item> lista=new ArrayList<Item>();
        
        try{
            Connection con=UsuarioDao.getConnection();
            String q;
            q="SELECT * FROM items";
            
            PreparedStatement ps=con.prepareStatement(q);
            
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                Item e=new Item();
                e.setId_item(rs.getInt(1));
                e.setItem(rs.getString(2));
                e.setStock(rs.getInt(3));
                e.setCosto(rs.getDouble(4));
                lista.add(e);
            }            
            
            System.out.println("Conexion exitosa... (getAllItems)");
            
            con.close();        
        }catch(Exception d){
            System.out.println("No hay conexion... (getAllItems)");
            System.out.println(d.getMessage());
            System.out.println(d.getStackTrace());
        }
        return lista;
    }
    //Obtiene los datos del item de la Vista
    public static Item getVItem(int id_item){
        Item e = new Item();
                
        try{
            Connection con=UsuarioDao.getConnection();
            String q;
            q="SELECT * FROM items WHERE id_item=?";

            PreparedStatement ps=con.prepareStatement(q);
            ps.setInt(1, id_item);
            
            ResultSet rs=ps.executeQuery();
            if (rs.next()) {
                e.setId_item(rs.getInt(1));
                e.setItem(rs.getString(2));
                e.setStock(rs.getInt(3));
                e.setCosto(rs.getDouble(4));
            }

            System.out.println("Conexion exitosa... (getItem)");
            
            con.close();        
        }catch(Exception d){
            System.out.println("No hay conexion... (getItem)");
            System.out.println(d.getMessage());
            System.out.println(d.getStackTrace());
        }
        return e;
    }
    public static int ElimStock(int cantidad, int id_item){
        int estatus=0;
        
        try{
            Connection con=UsuarioDao.getConnection();
            String q;
            q="UPDATE items SET stock=stock-? WHERE id_item=?";

            PreparedStatement ps=con.prepareStatement(q);
            ps.setInt(1, cantidad);
            ps.setInt(2, id_item);
            
            estatus=ps.executeUpdate();
            
            System.out.println("Conexion exitosa... (ElimStock)");
            
            con.close();
        
        }catch(Exception d){
            System.out.println("No hay conexion... (ElimStock)");
            System.out.println(d.getMessage());
            System.out.println(d.getStackTrace());
        }
        return estatus;
    }
    public static int DevolverStock(int cantidad, int id_item){
        int estatus=0;
        
        try{
            Connection con=UsuarioDao.getConnection();
            String q;
            q="UPDATE items SET stock=stock+? WHERE id_item=?";

            PreparedStatement ps=con.prepareStatement(q);
            ps.setInt(1, cantidad);
            ps.setInt(2, id_item);
            
            estatus=ps.executeUpdate();
            
            System.out.println("Conexion exitosa... (DevolverStock)");
            
            con.close();
        
        }catch(Exception d){
            System.out.println("No hay conexion... (DevolverStock)");
            System.out.println(d.getMessage());
            System.out.println(d.getStackTrace());
        }
        return estatus;
    }
    public static int FinalizarCompra(Carro e){
        int estatus=0;
        
        try{
            Connection con=UsuarioDao.getConnection();
            String q;
            q="UPDATE item SET stock=stock-? WHERE id_item=?";

            PreparedStatement ps=con.prepareStatement(q);
            ps.setInt(1, e.getCantidad());
            ps.setInt(2, e.getId_item());
            
            estatus=ps.executeUpdate();
            
            System.out.println("Conexion exitosa... (FinalizarCompra)");
            
            con.close();
        
        }catch(Exception d){
            System.out.println("No hay conexion... (FinalizarCompra)");
            System.out.println(d.getMessage());
            System.out.println(d.getStackTrace());
        }
        return estatus;
    }
}
