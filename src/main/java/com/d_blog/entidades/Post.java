package com.d_blog.entidades;

import java.util.Date;

public class Post {
    private int id;
    private String titulo;
    private String texto;
    private Usuario usuario;

    private Date timestamp;

    public Post(String titulo, String texto, Usuario usuario) {
        this.titulo = titulo;
        this.texto = texto;
        this.usuario = usuario;
    }

    public Post() {
    }

    public Post(int id) {
        this.id = id;
    }

    public Post(int id, String titulo, String texto, Usuario usuario, Date timestamp) {
        this.id = id;
        this.titulo = titulo;
        this.texto = texto;
        this.usuario = usuario;
        this.timestamp = timestamp;
    }

    public String getIntroTexto(){
        String intro = texto.substring(0, Math.min(15, texto.length()));
        intro += intro.length()<texto.length() ? "..." : "";
        return intro;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getTexto() {
        return texto;
    }

    public void setTexto(String texto) {
        this.texto = texto;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public Date getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Date timestamp) {
        this.timestamp = timestamp;
    }
}
