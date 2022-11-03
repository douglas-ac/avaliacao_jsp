package com.d_blog.entidades;

import java.util.Date;

public class Comentario {
    private int id;
    private String texto;
    private boolean status_aprovacao;
    private Post post;
    private Usuario usuario;
    private Date timestamp;

    public Comentario() {
    }

    public Comentario(String texto, boolean status_aprovacao, Post post, Usuario usuario) {
        this.texto = texto;
        this.status_aprovacao = status_aprovacao;
        this.post = post;
        this.usuario = usuario;
    }

    public Comentario(int id, String texto, boolean status_aprovacao, Post post, Usuario usuario, Date timestamp) {
        this.id = id;
        this.texto = texto;
        this.status_aprovacao = status_aprovacao;
        this.post = post;
        this.usuario = usuario;
        this.timestamp = timestamp;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTexto() {
        return texto;
    }

    public void setTexto(String texto) {
        this.texto = texto;
    }

    public boolean isStatus_aprovacao() {
        return status_aprovacao;
    }

    public void setStatus_aprovacao(boolean status_aprovacao) {
        this.status_aprovacao = status_aprovacao;
    }

    public Post getPost() {
        return post;
    }

    public void setPost(Post post) {
        this.post = post;
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
