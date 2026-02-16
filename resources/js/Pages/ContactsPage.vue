<template>
  <div class="contacts-page">
    <Head title="Контакты" />
    <Header />
    <main class="contacts-main">
      <div class="contacts-inner">
        <h1 class="page-title animate-item">Контакты</h1>
        <p class="page-desc animate-item animate-delay-1">Свяжитесь с нами любым удобным способом или оставьте заявку</p>

        <div class="info-cards animate-item animate-delay-2">
          <a href="tel:+79243016254" class="info-card">
            <span class="info-card-icon">📞</span>
            <span class="info-card-label">Телефон</span>
            <span class="info-card-value">+7 (924) 301-62-54</span>
          </a>
          <a href="mailto:crazyburgervdk@mail.com" class="info-card">
            <span class="info-card-icon">✉️</span>
            <span class="info-card-label">E-mail</span>
            <span class="info-card-value">crazyburgervdk@mail.com</span>
          </a>
          <div class="info-card">
            <span class="info-card-icon">📍</span>
            <span class="info-card-label">Адрес</span>
            <span class="info-card-value">г. Владивосток, ул. Шепеткова, 14</span>
          </div>
          <div class="info-card">
            <span class="info-card-icon">🕐</span>
            <span class="info-card-label">Режим работы</span>
            <span class="info-card-value">пн–пт 8:00–23:00<br />сб–вс выходной</span>
          </div>
        </div>

        <div class="contacts-two-col animate-item animate-delay-3">
          <section class="form-section">
            <h2 class="form-title">Напишите нам</h2>
            <p class="form-desc">Оставьте заявку — перезвоним в течение часа</p>

            <div v-if="showThankYou" class="thank-you-overlay" @click.self="showThankYou = false">
              <div class="thank-you-popup">
                <h3>Спасибо, заявка отправлена!</h3>
                <p>Ответим вам в течение часа</p>
                <button type="button" @click="showThankYou = false" class="btn-primary">Продолжить</button>
              </div>
            </div>

            <form @submit.prevent="submitForm" class="contacts-form">
              <div class="input-group">
                <input v-model="formData.name" type="text" placeholder="Имя" class="input" />
                <span v-if="errors.name" class="error-text">{{ errors.name }}</span>
              </div>
              <div class="input-group">
                <input v-model="formData.email" type="email" placeholder="E-mail" class="input" />
                <span v-if="errors.email" class="error-text">{{ errors.email }}</span>
              </div>
              <div class="input-group">
                <textarea v-model="formData.message" placeholder="Сообщение" class="input input-message" rows="4" />
                <span v-if="errors.message" class="error-text">{{ errors.message }}</span>
              </div>
              <button type="submit" class="btn-submit" :disabled="isSubmitting">
                {{ isSubmitting ? 'Отправка...' : 'Отправить' }}
              </button>
            </form>
          </section>

          <section class="map-section">
            <h2 class="map-title">Мы на карте</h2>
            <div class="map-wrap">
              <iframe
                src="https://yandex.ru/map-widget/v1/?ll=131.8820%2C43.1167&z=16&l=map&pt=131.8820,43.1167,pm2rdm"
                allowfullscreen
                loading="lazy"
                referrerpolicy="no-referrer-when-downgrade"
                title="Карта: Владивосток, ул. Шепеткова 14"
                class="map-iframe"
              />
            </div>
            <p class="map-address">г. Владивосток, ул. Шепеткова, 14</p>
          </section>
        </div>

        <div class="socials-block animate-item animate-delay-4">
          <h2 class="socials-title">Мы в соцсетях</h2>
          <div class="socials-links">
            <a href="https://vk.com/club234373639" target="_blank" rel="noopener" class="social-link" aria-label="VK">
              <img src="/assets/icons/VK.svg" alt="VK" />
            </a>
            <a href="https://chat.whatsapp.com/JtPMpccmxA1EydIB6UVUQ3" target="_blank" rel="noopener" class="social-link" aria-label="WhatsApp">
              <img src="/assets/icons/WA.svg" alt="WhatsApp" />
            </a>
            <a href="https://t.me/crazyberger" target="_blank" rel="noopener" class="social-link" aria-label="Telegram">
              <img src="/assets/icons/TG.svg" alt="Telegram" />
            </a>
          </div>
        </div>
      </div>
    </main>
    <Footer />
  </div>
</template>

<script>
import { Head } from '@inertiajs/vue3';
import Header from '@/Components/Header.vue';
import Footer from '@/Components/Footer.vue';

export default {
  name: 'ContactsPage',
  components: { Head, Header, Footer },
  data() {
    return {
      formData: { name: '', email: '', message: '' },
      errors: { name: '', email: '', message: '' },
      isSubmitting: false,
      showThankYou: false,
    }
  },
  methods: {
    validateForm() {
      this.errors = { name: '', email: '', message: '' }
      let valid = true
      if (!this.formData.name.trim()) {
        this.errors.name = 'Введите имя'
        valid = false
      }
      if (!this.formData.email.trim()) {
        this.errors.email = 'Введите email'
        valid = false
      } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(this.formData.email)) {
        this.errors.email = 'Введите корректный email'
        valid = false
      }
      if (!this.formData.message.trim()) {
        this.errors.message = 'Введите сообщение'
        valid = false
      } else if (this.formData.message.length < 5) {
        this.errors.message = 'Не менее 5 символов'
        valid = false
      }
      return valid
    },
    async submitForm() {
      if (!this.validateForm()) return
      this.isSubmitting = true
      try {
        await new Promise((r) => setTimeout(r, 1500))
        this.showThankYou = true
        this.formData = { name: '', email: '', message: '' }
        this.errors = { name: '', email: '', message: '' }
      } catch (e) {
        console.error(e)
      } finally {
        this.isSubmitting = false
      }
    },
  },
}
</script>

<style scoped>
.contacts-page {
  min-height: 100vh;
  background: var(--color-bg);
  color: var(--color-text);
}

.contacts-main {
  padding: 2rem 5% 3rem;
}

.contacts-inner {
  max-width: 1200px;
  margin: 0 auto;
}

.page-title {
  font-family: var(--font-heading);
  font-size: clamp(2rem, 4vw, 2.75rem);
  font-weight: 700;
  text-align: center;
  margin: 0 0 0.5rem;
}

.page-desc {
  text-align: center;
  color: var(--color-text-muted);
  font-size: 1.1rem;
  margin: 0 0 2.5rem;
}

.info-cards {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 1.25rem;
  margin-bottom: 3rem;
}

.info-card {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-lg);
  padding: 1.5rem;
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  text-decoration: none;
  color: inherit;
  transition: transform 0.25s, box-shadow 0.25s, border-color 0.25s;
}

a.info-card:hover {
  border-color: var(--color-primary);
  transform: translateY(-4px);
  box-shadow: var(--shadow-hover);
  color: var(--color-text);
}

.info-card-icon {
  font-size: 1.75rem;
}

.info-card-label {
  font-size: 0.8rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.06em;
  color: var(--color-text-muted);
}

.info-card-value {
  font-size: 1.05rem;
  font-weight: 600;
  line-height: 1.4;
}

.contacts-two-col {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 2rem;
  align-items: start;
  margin-bottom: 3rem;
}

.form-section,
.map-section {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-lg);
  padding: 1.75rem;
}

.form-title,
.map-title {
  font-family: var(--font-heading);
  font-size: 1.35rem;
  font-weight: 700;
  margin: 0 0 0.35rem;
}

.form-desc,
.map-address {
  font-size: 0.95rem;
  color: var(--color-text-muted);
  margin: 0 0 1.25rem;
}

.map-address {
  margin: 1rem 0 0;
}

.contacts-form {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.input-group {
  display: flex;
  flex-direction: column;
  gap: 0.35rem;
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

.input-message {
  min-height: 100px;
  resize: vertical;
}

.error-text {
  font-size: 0.85rem;
  color: var(--color-primary);
  font-weight: 600;
}

.btn-submit {
  padding: 0.9rem 1.25rem;
  background: var(--color-primary);
  color: #fff;
  font-size: 1rem;
  font-weight: 700;
  font-family: var(--font-body);
  border: none;
  border-radius: var(--radius);
  cursor: pointer;
  transition: background 0.2s, transform 0.2s;
}

.btn-submit:hover:not(:disabled) {
  background: var(--color-primary-hover);
  transform: translateY(-2px);
}

.btn-submit:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.map-wrap {
  border-radius: var(--radius);
  overflow: hidden;
  background: var(--color-surface-elevated);
  aspect-ratio: 4/3;
}

.map-iframe {
  width: 100%;
  height: 100%;
  border: none;
  display: block;
}

.thank-you-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.75);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
  padding: 1rem;
}

.thank-you-popup {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-lg);
  padding: 2rem;
  max-width: 380px;
  width: 100%;
  text-align: center;
  box-shadow: var(--shadow-hover);
}

.thank-you-popup h3 {
  font-family: var(--font-heading);
  font-size: 1.35rem;
  margin: 0 0 0.5rem;
}

.thank-you-popup p {
  color: var(--color-text-muted);
  margin: 0 0 1.25rem;
}

.btn-primary {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 0.75rem 1.75rem;
  background: var(--color-primary);
  color: #fff;
  font-size: 1rem;
  font-weight: 700;
  font-family: var(--font-body);
  border: none;
  border-radius: var(--radius);
  cursor: pointer;
  transition: background 0.2s;
}

.btn-primary:hover {
  background: var(--color-primary-hover);
  color: #fff;
}

.socials-block {
  text-align: center;
  padding: 2rem 0;
  border-top: 1px solid var(--color-border);
}

.socials-title {
  font-family: var(--font-heading);
  font-size: 1.25rem;
  margin: 0 0 1rem;
}

.socials-links {
  display: flex;
  justify-content: center;
  gap: 1.25rem;
}

.social-link {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 52px;
  height: 52px;
  border-radius: var(--radius);
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  transition: background 0.2s, transform 0.2s, border-color 0.2s;
}

.social-link:hover {
  background: var(--color-surface-hover);
  border-color: var(--color-primary);
  transform: translateY(-3px);
}

.social-link img {
  width: 28px;
  height: 28px;
  object-fit: contain;
}

@media (max-width: 900px) {
  .contacts-two-col {
    grid-template-columns: 1fr;
  }

  .map-wrap {
    aspect-ratio: 16/10;
  }
}

@media (max-width: 768px) {
  .contacts-main {
    padding: 1.5rem 4% 2rem;
  }

  .page-title {
    font-size: 1.75rem;
  }

  .page-desc {
    font-size: 1rem;
    margin-bottom: 2rem;
  }

  .info-cards {
    grid-template-columns: repeat(2, 1fr);
    gap: 1rem;
    margin-bottom: 2rem;
  }

  .info-card {
    padding: 1.25rem;
  }

  .info-card-value {
    font-size: 0.95rem;
  }

  .contacts-two-col {
    gap: 1.5rem;
    margin-bottom: 2rem;
  }

  .form-section,
  .map-section {
    padding: 1.5rem;
  }

  .form-title,
  .map-title {
    font-size: 1.2rem;
  }

  .socials-block {
    padding: 1.5rem 0;
  }

  .socials-title {
    font-size: 1.1rem;
  }

  .social-link {
    width: 46px;
    height: 46px;
  }

  .thank-you-popup {
    padding: 1.5rem;
    margin: 0 1rem;
  }

  .thank-you-popup h3 {
    font-size: 1.2rem;
  }
}

@media (max-width: 480px) {
  .contacts-main {
    padding: 1rem 3% 1.5rem;
  }

  .page-title {
    font-size: 1.5rem;
  }

  .page-desc {
    font-size: 0.95rem;
    margin-bottom: 1.5rem;
  }

  .info-cards {
    grid-template-columns: 1fr;
    gap: 0.75rem;
    margin-bottom: 1.5rem;
  }

  .info-card {
    padding: 1rem;
  }

  .info-card-icon {
    font-size: 1.5rem;
  }

  .info-card-label {
    font-size: 0.75rem;
  }

  .info-card-value {
    font-size: 0.9rem;
  }

  .contacts-two-col {
    margin-bottom: 1.5rem;
  }

  .form-section,
  .map-section {
    padding: 1.25rem;
  }

  .form-title,
  .map-title {
    font-size: 1.1rem;
  }

  .input {
    padding: 0.8rem 1rem;
    font-size: 16px; /* отключает зум на iOS при фокусе */
  }

  .input-message {
    min-height: 90px;
  }

  .map-wrap {
    aspect-ratio: 4/3;
  }

  .socials-links {
    gap: 1rem;
  }

  .social-link {
    width: 44px;
    height: 44px;
  }

  .social-link img {
    width: 24px;
    height: 24px;
  }
}
</style>
