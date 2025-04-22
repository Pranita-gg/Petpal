<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 21/04/2025
  Time: 11:07 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>PetPal - Frequently Asked Questions</title>
  <style>
    body {
      font-family: 'Helvetica Neue', Arial, sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f5f5f5;
      color: #333;
    }

    .faq-section {
      max-width: 1200px;
      margin: 2rem auto;
      padding: 0 1rem;
    }

    .faq-header {
      text-align: center;
      color: #0055a4;
      margin-bottom: 2rem;
    }

    .faq-header h1 {
      font-size: 2.5rem;
      margin-bottom: 1rem;
    }

    .faq-header p {
      font-size: 1.2rem;
      color: #666;
    }

    .faq-categories {
      display: flex;
      flex-wrap: wrap;
      gap: 2rem;
      margin-bottom: 3rem;
      justify-content: center;
    }

    .faq-category {
      background: white;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
      padding: 2rem;
      flex: 1;
      min-width: 300px;
      max-width: 400px;
    }

    .faq-category h2 {
      color: #0055a4;
      margin-bottom: 1.5rem;
      font-size: 1.5rem;
    }

    .faq-item {
      margin-bottom: 1.5rem;
      border-bottom: 1px solid #eee;
      padding-bottom: 1rem;
    }

    .faq-question {
      font-weight: bold;
      color: #333;
      margin-bottom: 0.5rem;
      cursor: pointer;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .faq-question::after {
      content: '+';
      font-size: 1.5rem;
      color: #0055a4;
    }

    .faq-question.active::after {
      content: '-';
    }

    .faq-answer {
      display: none;
      color: #666;
      line-height: 1.6;
      padding-top: 0.5rem;
    }

    .faq-answer.show {
      display: block;
    }

    .contact-section {
      text-align: center;
      margin-top: 3rem;
      padding: 2rem;
      background: #f8f9fa;
      border-radius: 10px;
    }

    .contact-section h3 {
      color: #0055a4;
      margin-bottom: 1rem;
    }

    .contact-button {
      display: inline-block;
      background-color: #ff6200;
      color: white;
      padding: 0.75rem 1.5rem;
      border-radius: 25px;
      text-decoration: none;
      font-weight: bold;
      transition: background-color 0.2s;
    }

    .contact-button:hover {
      background-color: #e55a00;
    }

    @media (max-width: 768px) {
      .faq-category {
        min-width: 100%;
      }
    }
  </style>
</head>
<body>
<jsp:include page="header.jsp"/>

<main class="faq-section">
  <div class="faq-header">
    <h1>Frequently Asked Questions</h1>
    <p>Find answers to common questions about pet adoption and our services</p>
  </div>

  <div class="faq-categories">
    <div class="faq-category">
      <h2>Adoption Process</h2>
      <div class="faq-item">
        <div class="faq-question">How do I adopt a pet through PetPal?</div>
        <div class="faq-answer">
          Start by browsing our available pets, submit an adoption application online, and our team will review your application within 24-48 hours. After approval, you'll be able to schedule a meet-and-greet with your potential new family member.
        </div>
      </div>
      <div class="faq-item">
        <div class="faq-question">What are the adoption fees?</div>
        <div class="faq-answer">
          Adoption fees vary depending on the type and age of the pet. Dogs typically range from $150-$400, cats from $50-$200. All adopted pets are spayed/neutered, vaccinated, and microchipped.
        </div>
      </div>
      <div class="faq-item">
        <div class="faq-question">What documents do I need to adopt?</div>
        <div class="faq-answer">
          You'll need a valid ID, proof of residence, and if you're renting, a letter from your landlord confirming pet approval. Some adoptions may require additional references.
        </div>
      </div>
    </div>

    <div class="faq-category">
      <h2>Pet Care</h2>
      <div class="faq-item">
        <div class="faq-question">What supplies do I need for my new pet?</div>
        <div class="faq-answer">
          Essential supplies include food and water bowls, appropriate food, bedding, collar and ID tag, leash (for dogs), litter box (for cats), grooming supplies, and toys. We'll provide a complete checklist during the adoption process.
        </div>
      </div>
      <div class="faq-item">
        <div class="faq-question">Do you offer post-adoption support?</div>
        <div class="faq-answer">
          Yes! We provide ongoing support through our pet behavior helpline, training resources, and veterinary advice. Our team is always here to help ensure a successful adoption.
        </div>
      </div>
      <div class="faq-item">
        <div class="faq-question">What if the adoption doesn't work out?</div>
        <div class="faq-answer">
          We have a 30-day adoption guarantee. If things don't work out, you can return the pet and receive a full refund of the adoption fee. We want both you and the pet to be happy!
        </div>
      </div>
    </div>

    <div class="faq-category">
      <h2>General Questions</h2>
      <div class="faq-item">
        <div class="faq-question">Can I foster a pet instead of adopting?</div>
        <div class="faq-answer">
          Yes! We always need foster homes. Fostering is a great way to help animals and see if pet ownership is right for you. Contact us to learn more about our foster program.
        </div>
      </div>
      <div class="faq-item">
        <div class="faq-question">How can I volunteer with PetPal?</div>
        <div class="faq-answer">
          We offer various volunteer opportunities, from helping at adoption events to providing administrative support. Fill out our volunteer application form to get started.
        </div>
      </div>
      <div class="faq-item">
        <div class="faq-question">Do you accept pet surrenders?</div>
        <div class="faq-answer">
          Yes, but we require an appointment and evaluation first. We also offer resources that might help you keep your pet if you're facing temporary difficulties.
        </div>
      </div>
    </div>
  </div>

  <div class="contact-section">
    <h3>Still have questions?</h3>
    <p>Our team is here to help you with any additional questions you might have.</p>
    <a href="contact.jsp" class="contact-button">Contact Us</a>
  </div>
</main>

<jsp:include page="footer.jsp"/>

<script>
  document.querySelectorAll('.faq-question').forEach(question => {
    question.addEventListener('click', () => {
      const answer = question.nextElementSibling;
      const isOpen = answer.classList.contains('show');

      // Close all answers
      document.querySelectorAll('.faq-answer').forEach(a => {
        a.classList.remove('show');
      });
      document.querySelectorAll('.faq-question').forEach(q => {
        q.classList.remove('active');
      });

      // Open clicked answer if it was closed
      if (!isOpen) {
        answer.classList.add('show');
        question.classList.add('active');
      }
    });
  });
</script>
</body>
</html>