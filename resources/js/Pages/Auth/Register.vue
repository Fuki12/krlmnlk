<template>
  <div class="auth-page">
    <Head title="Регистрация" />
    <Header />
    <main class="auth-main">
      <div class="auth-inner">
        <h1 class="page-title animate-item">Регистрация</h1>
        <p class="page-desc animate-item animate-delay-1">Создайте аккаунт для входа в личный кабинет</p>

        <div class="auth-card animate-item animate-delay-2">
          <form @submit.prevent="submit" class="auth-form">
            <div class="input-group">
              <label for="name" class="input-label">Имя</label>
              <input
                id="name"
                v-model="form.name"
                type="text"
                class="input"
                required
                autofocus
                autocomplete="name"
                placeholder="Ваше имя"
              />
              <span v-if="form.errors.name" class="error-text">{{ form.errors.name }}</span>
            </div>

            <div class="input-group">
              <label for="email" class="input-label">E-mail</label>
              <input
                id="email"
                v-model="form.email"
                type="email"
                class="input"
                required
                autocomplete="username"
                placeholder="example@mail.ru"
              />
              <span v-if="form.errors.email" class="error-text">{{ form.errors.email }}</span>
            </div>

            <div class="input-group">
              <label for="password" class="input-label">Пароль</label>
              <input
                id="password"
                v-model="form.password"
                type="password"
                class="input"
                required
                autocomplete="new-password"
                placeholder="Минимум 8 символов"
              />
              <span v-if="form.errors.password" class="error-text">{{ form.errors.password }}</span>
            </div>

            <div class="input-group">
              <label for="password_confirmation" class="input-label">Подтверждение пароля</label>
              <input
                id="password_confirmation"
                v-model="form.password_confirmation"
                type="password"
                class="input"
                required
                autocomplete="new-password"
                placeholder="Повторите пароль"
              />
              <span v-if="form.errors.password_confirmation" class="error-text">{{ form.errors.password_confirmation }}</span>
            </div>

            <button type="submit" class="btn-submit" :disabled="form.processing">
              {{ form.processing ? 'Регистрация...' : 'Зарегистрироваться' }}
            </button>
          </form>

          <p class="auth-footer-text">
            Уже есть аккаунт?
            <Link :href="route('login')" class="auth-link">Войти</Link>
          </p>
        </div>

        <Link :href="route('home')" class="back-home animate-item animate-delay-3">← На главную</Link>
      </div>
    </main>
    <Footer />
  </div>
</template>

<script setup>
import { Head, Link, useForm } from '@inertiajs/vue3';
import Header from '@/Components/Header.vue';
import Footer from '@/Components/Footer.vue';

const form = useForm({
  name: '',
  email: '',
  password: '',
  password_confirmation: '',
});

const submit = () => {
  form.post(route('register'), {
    onFinish: () => form.reset('password', 'password_confirmation'),
  });
};
</script>

<style scoped>
.auth-page {
  min-height: 100vh;
  background: var(--color-bg);
  color: var(--color-text);
}

.auth-main {
  padding: 2rem 5% 3rem;
}

.auth-inner {
  max-width: 440px;
  margin: 0 auto;
}

.page-title {
  font-family: var(--font-heading);
  font-size: clamp(2rem, 4vw, 2.5rem);
  font-weight: 700;
  text-align: center;
  margin: 0 0 0.5rem;
}

.page-desc {
  text-align: center;
  color: var(--color-text-muted);
  font-size: 1rem;
  margin: 0 0 2rem;
}

.auth-card {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-lg);
  padding: 2rem;
  margin-bottom: 1.5rem;
  box-shadow: var(--shadow);
}

.auth-form {
  display: flex;
  flex-direction: column;
  gap: 1.25rem;
}

.input-group {
  display: flex;
  flex-direction: column;
  gap: 0.35rem;
}

.input-label {
  font-size: 0.9rem;
  font-weight: 600;
  color: var(--color-text-muted);
}

.input {
  width: 100%;
  padding: 0.9rem 1.1rem;
  font-size: 1rem;
  font-family: var(--font-body);
  color: var(--color-text);
  background: var(--color-surface-elevated);
  border: 1px solid var(--color-border);
  border-radius: var(--radius);
  transition: border-color 0.2s, box-shadow 0.2s;
  box-sizing: border-box;
}

.input::placeholder {
  color: var(--color-text-soft);
}

.input:focus {
  outline: none;
  border-color: var(--color-primary);
  box-shadow: 0 0 0 3px var(--color-primary-glow);
}

.error-text {
  font-size: 0.85rem;
  color: var(--color-primary);
  font-weight: 600;
}

.btn-submit {
  padding: 1rem 1.5rem;
  background: var(--color-primary);
  color: #fff;
  font-size: 1.05rem;
  font-weight: 700;
  font-family: var(--font-body);
  border: none;
  border-radius: var(--radius);
  cursor: pointer;
  transition: background 0.2s, transform 0.2s;
  margin-top: 0.25rem;
}

.btn-submit:hover:not(:disabled) {
  background: var(--color-primary-hover);
  transform: translateY(-2px);
}

.btn-submit:disabled {
  opacity: 0.7;
  cursor: not-allowed;
  transform: none;
}

.auth-footer-text {
  text-align: center;
  margin: 1.5rem 0 0;
  padding-top: 1.5rem;
  border-top: 1px solid var(--color-border);
  font-size: 0.95rem;
  color: var(--color-text-muted);
}

.auth-footer-text .auth-link {
  margin-left: 0.25rem;
}

.auth-link {
  color: var(--color-accent);
  text-decoration: none;
  font-size: 0.95rem;
  font-weight: 600;
}

.auth-link:hover {
  color: var(--color-primary);
  text-decoration: underline;
}

.back-home {
  display: inline-flex;
  align-items: center;
  color: var(--color-text-muted);
  text-decoration: none;
  font-size: 0.95rem;
  font-weight: 600;
  transition: color 0.2s;
}

.back-home:hover {
  color: var(--color-primary);
}

@media (max-width: 480px) {
  .auth-main {
    padding: 1.5rem 3% 2rem;
  }

  .auth-card {
    padding: 1.5rem;
  }

  .input {
    font-size: 16px;
  }
}
</style>
