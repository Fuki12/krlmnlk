<template>
  <section id="contacts" class="contacts-section">
    <div class="contacts-inner">
      <h2 class="contacts-title">Связаться с нами</h2>
      <p class="contacts-desc">Оставьте заявку — перезвоним в течение часа</p>

      <div v-if="showThankYou" class="thank-you-overlay" @click.self="showThankYou = false">
        <div class="thank-you-popup">
          <h3>Спасибо, заявка отправлена!</h3>
          <p>Ответим вам в течение часа</p>
          <button type="button" @click="showThankYou = false" class="btn-primary">Продолжить</button>
        </div>
      </div>

      <form @submit.prevent="submitForm" class="contacts-form">
        <div class="input-group">
          <input
            v-model="formData.name"
            type="text"
            placeholder="Имя"
            class="input"
          />
          <span v-if="errors.name" class="error-text">{{ errors.name }}</span>
        </div>
        <div class="input-group">
          <input
            v-model="formData.email"
            type="email"
            placeholder="E-mail"
            class="input"
          />
          <span v-if="errors.email" class="error-text">{{ errors.email }}</span>
        </div>
        <div class="input-group">
          <textarea
            v-model="formData.message"
            placeholder="Сообщение"
            class="input input-message"
            rows="4"
          />
          <span v-if="errors.message" class="error-text">{{ errors.message }}</span>
        </div>
        <button type="submit" class="btn-submit" :disabled="isSubmitting">
          {{ isSubmitting ? 'Отправка...' : 'Отправить' }}
        </button>
      </form>
    </div>
  </section>
</template>

<script>
export default {
  name: 'Contacts',
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
.contacts-section {
  padding: 4rem 5%;
  background: var(--color-bg);
}

.contacts-inner {
  max-width: 560px;
  margin: 0 auto;
  background: var(--color-surface);
  border-radius: var(--radius-lg);
  padding: 2.5rem;
  border: 1px solid var(--color-border);
  box-shadow: var(--shadow);
}

.contacts-title {
  font-family: var(--font-heading);
  font-size: 1.75rem;
  font-weight: 700;
  color: var(--color-text);
  margin: 0 0 0.5rem;
  text-align: center;
}

.contacts-desc {
  font-size: 1rem;
  color: var(--color-text-muted);
  margin: 0 0 2rem;
  text-align: center;
}

.contacts-form {
  display: flex;
  flex-direction: column;
  gap: 1.25rem;
}

.input-group {
  display: flex;
  flex-direction: column;
  gap: 0.35rem;
}

.input {
  width: 100%;
  padding: 1rem 1.25rem;
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
  min-height: 120px;
  resize: vertical;
}

textarea.input {
  resize: vertical;
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
  margin-top: 0.5rem;
}

.btn-submit:hover:not(:disabled) {
  background: var(--color-primary-hover);
  transform: translateY(-2px);
}

.btn-submit:disabled {
  opacity: 0.6;
  cursor: not-allowed;
  transform: none;
}

/* Попап */
.thank-you-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.7);
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
  padding: 2.5rem;
  max-width: 400px;
  width: 100%;
  text-align: center;
  box-shadow: var(--shadow-hover);
}

.thank-you-popup h3 {
  font-family: var(--font-heading);
  font-size: 1.5rem;
  color: var(--color-text);
  margin: 0 0 0.75rem;
}

.thank-you-popup p {
  color: var(--color-text-muted);
  margin: 0 0 1.5rem;
}

.thank-you-popup .btn-primary {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 0.85rem 2rem;
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

.thank-you-popup .btn-primary:hover {
  background: var(--color-primary-hover);
  color: #fff;
}
</style>
